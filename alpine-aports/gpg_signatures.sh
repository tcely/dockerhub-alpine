#!/usr/bin/env sh

#filename_from_uri() {
#  local uri filename
#  uri="$1"
#  filename="${uri##*/}"  # $(basename $uri)
#  case "$uri" in
#  *::*) filename="${uri%%::*}" ;;
#  esac
#  echo "$filename"
#}

url_from_uri() {
  local uri url
  uri="$1"
  case "$uri" in
  *::*) url="${uri#*::}" ;;
  *)    url="$uri" ;;
  esac
  echo "$url"
}

sourcecheck() {
	local uri
	for uri in $source; do
		is_remote $uri || continue
		wget --spider -q "$(url_from_uri "$uri")" || return 1
	done
	return 0
}

uri_fetch() {
  local uri filename as
  uri="$1"
  filename="$(filename_from_uri "$uri")"
  [ "$filename" != "${uri##*/}" ] && as="$filename" || as=""
  mkdir -p "$SRCDEST"
  msg "Fetching $(url_from_uri "$uri")${as:+ as $as}"
  abuild-fetch -d "$SRCDEST" "$uri"
}

fetch_gpg_signatures() {
  local fetched filename sigext uri url

  [ -n "$gpgfingerprints" ] || return 0
  [ -n "$gpg_signature_extensions" ] || return 0

  uri="$1"
  url="$(url_from_uri "$uri")"
  filename="$(filename_from_uri "$uri")"
  [ "$filename" != "${pkgname}-GPGKEYS" ] || return 0
  list_has "$uri" ${gpgsource:-$source} || return 0

  fetched=false
  for sigext in $gpg_signature_extensions; do
    [ "." = "$sigext" ] && sigext="" || sigext=".${sigext}"
    uri_fetch_mirror "${filename}${sigext}::${url}${sigext}" && \
    ln -sf "${SRCDEST}/${filename}${sigext}" "$srcdir"/ && fetched=true || :
  done

  if ! $fetched; then
    error "Could not fetch any GPG signatures for ${filename}"
    error2 "Try adjusting gpg_signature_extensions variable in APKBUILD"
    error2 "Remove the URI from gpgsource if there is no GPG signature"
    return 1
  fi

  return 0
}

gpg_verify() {
  local allverified

  if [ -n "$source" ] && \
    [ -n "$gpgfingerprints" ] && \
    [ -n "$(command -v gpg2)" ] && \
    gpg2 --version >/dev/null
  then
    local gpgkeys
    for gpgkeys in "${startdir}/GPGKEYS" "${srcdir}/${pkgname}-GPGKEYS"; do
      [ -s "$gpgkeys" ] || continue
      msg "Importing from $gpgkeys"
      gpg2 --homedir "${srcdir}/.gnupg" --quiet \
        --keyid-format 0xlong \
        --auto-key-retrieve \
        --trust-model tofu+pgp \
        --key-origin "url,file://${gpgkeys}" \
        --import "$gpgkeys"
    done

    local trust fingerprint
    echo "$gpgfingerprints" | tr ',' '\n' | while IFS=: read -r trust fingerprint; do
      case "$(printf -- '%s' $trust)" in
        good) trust='good' ;;
        ""|unknown) trust='unknown' ;;
        *) fingerprint="$trust"; trust='unknown' ;;
      esac
      fingerprint="$(printf -- '%s' $fingerprint)"
      # fingerprint="${fingerprint//[^A-F0-9a-f]}" # not POSIX, but does eliminate GPG errors
      case "${#fingerprint}" in
        40) ;;
        *) continue ;;
      esac

      # use redirection because no output or errors matter
      if ! gpg2 >/dev/null 2>&1 --homedir "${srcdir}/.gnupg" \
        --keyid-format 0xlong \
        --auto-key-retrieve \
        --trust-model tofu+pgp \
        --list-keys "$fingerprint"
      then
        gpg2 --homedir "${srcdir}/.gnupg" --quiet \
          --keyid-format 0xlong \
          --auto-key-retrieve \
          --trust-model tofu+pgp \
          --recv-key "$fingerprint"
      fi

      # use redirection because --quiet doesn't affect tofu policy logging
      gpg2 >/dev/null 2>&1 --homedir "${srcdir}/.gnupg" \
        --keyid-format 0xlong \
        --auto-key-retrieve \
        --trust-model tofu+pgp \
        --tofu-policy "$trust" "$fingerprint"
    done

    allverified=true

    local uri filename srcpath gpgverified
    for uri in ${gpgsource:-$source}; do
      filename="$(filename_from_uri "$uri")"
      [ "$filename" != "${pkgname}-GPGKEYS" ] || continue
      srcpath="${srcdir}/${filename}"
      gpgverified=false

      local sigext
      for sigext in $gpg_signature_extensions; do
        local sigfile
        sigfile="${srcpath}.${sigext}"
        if [ "." = "$sigext" ]; then
          sigfile="${srcpath}"
          sigext=""
        fi

        [ -s "$sigfile" ] || continue
        if gpg2 --homedir "${srcdir}/.gnupg" --verbose \
          --keyid-format 0xlong \
          --auto-key-retrieve \
          --trust-model tofu+pgp \
          --tofu-default-policy bad \
          --verify "$sigfile" ${sigext:+"$srcpath"}
        then
          gpgverified=true
          break
        fi
      done

      if ! $gpgverified && is_remote "$uri"; then
        allverified=false
        error "${filename} does not have a valid GPG signature"
      fi
    done

    if ! $allverified; then
      return 1
    fi
  fi

  return 0
}

verify() {
  gpg_verify
  default_verify
}

gpg_signature_extensions="${gpg_signature_extensions:-sig asc}"
