FROM alpine:edge
LABEL maintainer="https://keybase.io/tcely"

ENV PAGER=less

RUN apk --update add \
        less man \
        dhcp dhcp-doc \
        && \
    : >> /var/lib/dhcp/dhcpd.leases && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

EXPOSE 67/tcp 67/udp
VOLUME ["/etc/dhcp"]

ENTRYPOINT ["/usr/sbin/dhcpd", "-4", "-f", "-d"]
CMD ["--no-pid", "-cf", "/etc/dhcp/dhcpd.conf"]
