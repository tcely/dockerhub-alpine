FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

EXPOSE 53/tcp 53/udp

RUN apk --update add \
        ca-certificates \
        unbound unbound-doc \
        && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/sbin/unbound", "-d", "-p"]
CMD ["-h"]
