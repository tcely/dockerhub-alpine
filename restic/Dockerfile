FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

RUN apk --update add \
        ca-certificates fuse openssh-client \
        restic restic-doc \
        && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/restic"]
CMD ["--help"]
