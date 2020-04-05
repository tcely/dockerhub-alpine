FROM tcely/alpine-aports:builder-quassel AS builder

FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

COPY --from=builder /etc/apk/keys /etc/apk/keys
COPY --from=builder /home/buildozer/packages /var/cache/apk-packages
RUN printf >> /etc/apk/repositories -- \
        '%s\n' /var/cache/apk-packages/*

RUN apk --update add \
        ca-certificates openssl \
        quassel-core \
        && \
    rm -rf /var/cache/apk/*

RUN install -d -m 00770 -o quassel -g quassel /data

EXPOSE 4242/tcp 10113/tcp
USER quassel:quassel

RUN openssl req -x509 -nodes -batch -days 680 -newkey rsa \
        -keyout /var/lib/quassel/quasselCert.pem \
        -out /var/lib/quassel/quasselCert.pem && \
    cp -p /var/lib/quassel/quasselCert.pem /data/

VOLUME ["/data"]

ENV DB_BACKEND="SQLite" AUTH_AUTHENTICATOR="Database"
ENV DB_PGSQL_USERNAME="quassel" DB_PGSQL_PASSWORD="" DB_PGSQL_HOSTNAME="pgsql" DB_PGSQL_PORT="5432" DB_PGSQL_DATABASE="quassel"
ENV AUTH_LDAP_HOSTNAME="ldap://ldap" AUTH_LDAP_PORT="389" AUTH_LDAP_BIND_DN="" AUTH_LDAP_BIND_PASSWORD="" AUTH_LDAP_BASE_DN="" AUTH_LDAP_FILTER="" AUTH_LDAP_UID_ATTRIBUTE="uid"

ENTRYPOINT ["/usr/bin/quasselcore", "--configdir", "/data"]
CMD ["--help"]
