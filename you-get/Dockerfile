FROM alpine:edge
LABEL maintainer="https://keybase.io/tcely"

ENV PAGER=less

RUN apk --update add \
        less man \
        ffmpeg you-get \
        && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

VOLUME ["/out"]
ENTRYPOINT ["/usr/bin/you-get", "--auto-rename", "--output-dir", "/out"]
