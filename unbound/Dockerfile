FROM alpine:edge
LABEL maintainer="https://keybase.io/tcely"

ENV PAGER=less

RUN apk --update add \
        less man \
        ca-certificates \
        unbound unbound-doc \
        && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/sbin/unbound", "-d", "-p"]
CMD ["-h"]
