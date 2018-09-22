FROM alpine:edge
LABEL maintainer="https://keybase.io/tcely"

ENV PAGER=less

RUN apk --update add \
        less man \
        pdns-recursor pdns-recursor-doc \
        && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/sbin/pdns_recursor"]
CMD ["--help"]
