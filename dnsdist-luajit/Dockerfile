FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"


# testing repository is not enabled by default
RUN sed -i.orig -e '/community$/{p;s/community$/testing/;}' /etc/apk/repositories

RUN apk --update add \
        dnsdist-luajit dnsdist-doc \
        && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/dnsdist"]
CMD ["--help"]
