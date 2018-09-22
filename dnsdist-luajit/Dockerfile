FROM alpine:edge
LABEL maintainer="https://keybase.io/tcely"

ENV PAGER=less

# testing repository is not enabled by default
RUN sed -i.orig -e '/community$/{p;s/community$/testing/;}' /etc/apk/repositories

RUN apk --update add \
        less man \
        dnsdist-luajit dnsdist-doc \
        && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/dnsdist"]
CMD ["--help"]
