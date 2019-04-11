FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

EXPOSE 53/tcp 53/udp

RUN apk --update add \
        dnsdist dnsdist-doc \
        && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/dnsdist"]
CMD ["--help"]
