FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

RUN apk --update add \
        xkcdpass \
        && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/xkcdpass"]
CMD ["--help"]
