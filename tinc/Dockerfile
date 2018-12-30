FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

EXPOSE 655/tcp 655/udp

RUN apk --update add \
        bash ca-certificates \
        tinc tinc-doc \
        && \
    rm -rf /var/cache/apk/*

VOLUME /etc/tinc

ENTRYPOINT ["/usr/sbin/tincd", "-D"]
CMD ["--help"]
