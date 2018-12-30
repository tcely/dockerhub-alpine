FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

EXPOSE 53/tcp 53/udp

RUN apk --update add \
        pdns-recursor pdns-recursor-doc \
        && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/sbin/pdns_recursor"]
CMD ["--help"]
