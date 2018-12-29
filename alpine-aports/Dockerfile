FROM alpine:edge
LABEL maintainer="https://keybase.io/tcely"

ENV PAGER=less

RUN apk --update add \
        less man \
        && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

