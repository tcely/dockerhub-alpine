FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

EXPOSE 636/tcp 636/udp 389/tcp 389/udp

RUN apk --update add \
        openldap openldap-clients openldap-passwd-pbkdf2 \
        openldap-backend-all openldap-overlay-all \
        && \
    mkdir /var/run/openldap && \
    chown -R ldap:ldap /var/run/openldap && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/sbin/slapd", "-u", "ldap", "-g", "ldap"]
CMD ["-VVV"]
