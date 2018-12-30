FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"


RUN apk --update add \
        pdns-backend-bind pdns-backend-sqlite3 \
        pdns-backend-mysql pdns-backend-pgsql \
        pdns-backend-lua pdns-backend-pipe \
        pdns-backend-random pdns-backend-remote \
        pdns-backend-geoip \
        pdns-tools pdns-doc \
        && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/sbin/pdns_server"]
CMD ["--help"]
