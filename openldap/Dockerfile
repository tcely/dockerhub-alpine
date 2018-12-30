FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"


RUN apk --update add \
        openldap openldap-clients \
        openldap-back-bdb openldap-back-hdb openldap-back-mdb openldap-back-ldap \
        && \
    mkdir /var/run/openldap && \
    chown -R ldap:ldap /var/run/openldap && \
    rm -rf /var/cache/apk/*

EXPOSE 636 636/udp 389 389/udp
ENTRYPOINT ["/usr/sbin/slapd", "-u", "ldap", "-g", "ldap"]
CMD ["-VVV"]
