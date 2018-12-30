FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"


RUN apk --update add \
        bash ca-certificates \
        tinc tinc-doc \
        && \
    rm -rf /var/cache/apk/*

EXPOSE 655/tcp 655/udp
VOLUME /etc/tinc

ENTRYPOINT ["/usr/sbin/tincd", "-D"]
CMD ["--help"]
