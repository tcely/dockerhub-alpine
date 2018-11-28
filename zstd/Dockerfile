FROM alpine:edge
LABEL maintainer="https://keybase.io/tcely"

ENV PAGER=less

RUN apk --update add \
        less man \
        ca-certificates \
        zstd zstd-doc \
        && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/zstd"]
CMD ["--help"]
