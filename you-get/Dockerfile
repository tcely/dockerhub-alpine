FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

RUN apk --update add \
        ca-certificates ffmpeg you-get \
        && \
    rm -rf /var/cache/apk/*

VOLUME ["/out"]

ENTRYPOINT ["/usr/bin/you-get", "--auto-rename", "--output-dir", "/out"]
