FROM alpine:edge

RUN apk --update add you-get && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

VOLUME ["/out"]
ENTRYPOINT ["/usr/bin/you-get", "--auto-rename", "--output-dir", "/out"]
