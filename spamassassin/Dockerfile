FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

RUN apk --update add \
        spamassassin \
        && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/sbin/spamd"]
CMD ["--help"]
