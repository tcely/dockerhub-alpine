FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"


RUN apk --update add \
        dhcp dhcp-doc \
        && \
    : >> /var/lib/dhcp/dhcpd.leases && \
    rm -rf /var/cache/apk/*

EXPOSE 67/tcp 67/udp
VOLUME ["/etc/dhcp"]

ENTRYPOINT ["/usr/sbin/dhcpd", "-4", "-f", "-d"]
CMD ["--no-pid", "-cf", "/etc/dhcp/dhcpd.conf"]
