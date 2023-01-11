FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

EXPOSE 636/tcp 636/udp 389/tcp 389/udp

RUN apk --update add \
        openldap openldap-clients openldap-passwd-pbkdf2 \
        openldap-backend-all openldap-overlay-all \
        && \
    rm -rf /var/cache/apk/*

# Ensure the proper directory exists.
# The package has started creating /var/run/openldap itself,
# but it didn't always do that.
RUN test -d /var/run/openldap || { \
    rm -v -rf /var/run/openldap && \
    mkdir -v /var/run/openldap ; }

# Ensure the proper ownership of the directory.
RUN chown -R ldap:ldap /var/run/openldap

ENTRYPOINT ["/usr/sbin/slapd", "-u", "ldap", "-g", "ldap"]
CMD ["-VVV"]
