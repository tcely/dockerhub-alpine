FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

EXPOSE 53/tcp 53/udp

RUN apk --update add \
        pdns-backend-bind pdns-backend-sqlite3 \
        pdns-backend-mysql pdns-backend-pgsql \
        pdns-backend-pipe \
        pdns-backend-remote \
        pdns-backend-geoip \
        pdns-tools pdns-doc \
        && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/sbin/pdns_server"]
CMD ["--help"]
