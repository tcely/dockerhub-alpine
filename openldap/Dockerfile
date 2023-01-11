FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

EXPOSE 636/tcp 636/udp 389/tcp 389/udp

RUN apk --update add \
        openldap openldap-clients openldap-passwd-pbkdf2 \
        openldap-backend-all openldap-overlay-all \
        && \
    rm -rf /var/cache/apk/*

# The package started creating /var/run/openldap itself
# it didn't used to do that. This might be safe to remove.
RUN ls -ld /var/run/openldap && \
    rm -v -rf /var/run/openldap && \
    mkdir -v /var/run/openldap && \
    chown -v -R ldap:ldap /var/run/openldap

ENTRYPOINT ["/usr/sbin/slapd", "-u", "ldap", "-g", "ldap"]
CMD ["-VVV"]
