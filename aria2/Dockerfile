FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

RUN apk --update add \
        ca-certificates \
        aria2 aria2-doc \
        && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/aria2c"]
CMD ["--help=#all"]
