FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"


RUN apk --update add \
        pdns-recursor pdns-recursor-doc \
        && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/sbin/pdns_recursor"]
CMD ["--help"]
