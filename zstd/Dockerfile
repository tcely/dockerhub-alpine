FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

RUN apk --update add \
        ca-certificates \
        zstd zstd-doc \
        && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/zstd"]
CMD ["--help"]
