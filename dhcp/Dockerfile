FROM tcely/alpine-aports:builder-dhcp AS builder

FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

EXPOSE 67/tcp 67/udp

COPY --from=builder /etc/apk/keys /etc/apk/keys
COPY --from=builder /home/buildozer/packages /var/cache/apk-packages
RUN printf >> /etc/apk/repositories -- \
    '%s\n' /var/cache/apk-packages/*

RUN apk --update add \
        dhcp dhcp-doc \
        && \
    : >> /var/lib/dhcp/dhcpd.leases && \
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

VOLUME ["/etc/dhcp"]

ENTRYPOINT ["/usr/sbin/dhcpd", "-4", "-f", "-d"]
CMD ["--no-pid", "-cf", "/etc/dhcp/dhcpd.conf"]
