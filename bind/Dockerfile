FROM tcely/alpine-aports:builder-bind AS builder

FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 53/tcp 53/udp

COPY --from=builder /etc/apk/keys /etc/apk/keys
COPY --from=builder /home/buildozer/packages /var/cache/apk-packages
RUN printf >> /etc/apk/repositories -- \
        '%s\n' /var/cache/apk-packages/*

RUN apk --update add \
        bash ca-certificates \
        bind bind-plugins bind-tools bind-doc \
        && \
    rm -rf /var/cache/apk/*

RUN cd /var/cache/apk-packages ; \
    _installed="$( \
    find . -name \*.apk -type f -exec basename {} .apk \; | \
    while IFS= read -r _pkg; do \
      __n="${_pkg%%-[0-9.]*-r[0-9]*}" ; \
      __v="${_pkg##${__n}-}" ; \
      apk info -e "${__n}=${__v}" ; \
    done ; \
    )" ; \
    printf -- '%s\n' "${_installed}" ; \
    [ 0 -lt "$( printf -- '%s\n' "${_installed}" | wc -w )" ]

RUN chmod -c a+rx /entrypoint.sh && \
    cp -p /etc/bind/bind.keys /var/bind/ && \
    ln -f -s ../../var/run/named/rndc.key /etc/bind/rndc.key

# /var/cache/bind needs to be owned by "bind"
# since we are mounting, do it manually
# NOTE: Per Dockerfile manual --> need to mkdir the mounted dir to chown
RUN mkdir -m 0755 -p /var/run/named /var/cache/bind && \
    : >> /var/cache/bind/docker-init && \
    chown -R root:named /var/run/named && \
    chown -R named:named /var/cache/bind

# Mounts
# NOTE: Per Dockerfile manual -->
#	"if any build steps change the data within the volume
# 	 after it has been declared, those changes will be discarded."
VOLUME ["/etc/bind", "/var/bind", "/var/cache/bind"]
