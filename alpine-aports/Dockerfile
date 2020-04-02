FROM alpine:edge
LABEL maintainer="https://keybase.io/tcely"

ENV PAGER=less

RUN apk --update upgrade -a && \
    apk add \
        less mdocml \
        && \
    rm -rf /var/cache/apk/*

