FROM alpine:edge
LABEL maintainer="https://keybase.io/tcely"

ENV PAGER=less

RUN apk --update add \
        less man \
        bash ca-certificates \
        tinc tinc-doc \
        && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

EXPOSE 655/tcp 655/udp
VOLUME /etc/tinc

ENTRYPOINT ["/usr/sbin/tincd", "-D"]
CMD ["--help"]
