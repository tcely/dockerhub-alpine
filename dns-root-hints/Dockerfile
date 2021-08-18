FROM tcely/alpine-aports:builder-dns-root-hints AS builder

FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

COPY --from=builder /etc/apk/keys /etc/apk/keys
COPY --from=builder /home/buildozer/packages /var/cache/apk-packages
RUN printf >> /etc/apk/repositories -- \
    '%s\n' /var/cache/apk-packages/*

RUN apk --update add \
        dns-root-hints \
        && \
    rm -rf /var/cache/apk/*

