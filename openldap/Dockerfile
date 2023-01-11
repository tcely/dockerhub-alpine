FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

EXPOSE 636/tcp 636/udp 389/tcp 389/udp

RUN apk --update add \
        openldap openldap-clients openldap-passwd-pbkdf2 \
        openldap-backend-all openldap-overlay-all \
        && \
    rm -rf /var/cache/apk/*

# The package has started creating /var/run/openldap itself,
# but it didn't always do that. Ensure it exists.
RUN test -d /var/run/openldap || { \
    rm -v -rf /var/run/openldap && \
    mkdir -v /var/run/openldap ; }

# Enforce the ownership and display the results.
RUN ls -ld /var/run/openldap && \
    chown -v -R ldap:ldap /var/run/openldap && \
    ls -ld /var/run/openldap

ENTRYPOINT ["/usr/sbin/slapd", "-u", "ldap", "-g", "ldap"]
CMD ["-VVV"]
