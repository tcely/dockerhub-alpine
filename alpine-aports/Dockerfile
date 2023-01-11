FROM alpine:edge
LABEL maintainer="https://keybase.io/tcely"

ENV PAGER=less

RUN apk --update upgrade -a && \
    apk add \
        less mandoc \
        && \
    rm -rf /var/cache/apk/*

