FROM alpine:edge
LABEL maintainer="https://keybase.io/tcely"

ENV PAGER=less

RUN apk --update add \
        less man \
        openldap openldap-clients \
        openldap-back-bdb openldap-back-hdb openldap-back-mdb openldap-back-ldap \
        && \
    mkdir /var/run/openldap && \
    chown -R ldap:ldap /var/run/openldap && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

EXPOSE 636 636/udp 389 389/udp
ENTRYPOINT ["/usr/sbin/slapd", "-u", "ldap", "-g", "ldap"]
CMD ["-VVV"]
