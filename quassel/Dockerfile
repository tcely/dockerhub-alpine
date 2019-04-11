FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

RUN apk --update add \
        ca-certificates \
        quassel-core \
        && \
    rm -rf /var/cache/apk/*

RUN install -d -m 00770 -o quassel -g quassel /data

EXPOSE 4242/tcp
USER quassel:quassel

RUN openssl req -x509 -nodes -batch -days 680 -newkey rsa \
        -keyout /var/lib/quassel/quasselCert.pem \
        -out /var/lib/quassel/quasselCert.pem && \
    cp -p /var/lib/quassel/quasselCert.pem /data/

VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/quasselcore", "--configdir", "/data"]
CMD ["--help"]
