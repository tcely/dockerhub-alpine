FROM alpine:edge
LABEL maintainer="https://keybase.io/tcely"

ENV PAGER=less

RUN mkdir -v -p /var/cache/apk /etc/apk; \
    rm -v -f /etc/apk/cache; \
    ln -v -s ../../var/cache/apk /etc/apk/cache

RUN apk --update add \
        less man vim \
        alpine-sdk lua-aports \
        && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

ENV ALPINE_GROUP=abuild ALPINE_USER=builder
RUN adduser -G "${ALPINE_GROUP}" -s /bin/sh -D "${ALPINE_USER}" && \
    printf -- \
    '%%%s ALL=(ALL) NOPASSWD: ALL\n' \
    "${ALPINE_GROUP}" > "/etc/sudoers.d/${ALPINE_GROUP}" && \
    chgrp -c "${ALPINE_GROUP}" /etc/apk/repositories && \
    chmod -c g=rw /etc/apk/repositories

RUN printf -- '%s\n' > /alpine-builder \
    '#!/bin/sh' '' \
    'abuild_user() {' \
    '    local _dir _user' '' \
    "    _user='${ALPINE_USER}'" \
    '    _dir="$(realpath . | tr -d "'\''")"' '' \
    '    su -l "${_user}" sh -c "cd '\''${_dir}'\'' && $*"' \
    '}' && \
    chmod -c 00644 /alpine-builder

VOLUME ["/abuild", "/aports", "/var/cache/apk"]
USER "${ALPINE_USER}":"${ALPINE_GROUP}"
