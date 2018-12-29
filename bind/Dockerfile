FROM alpine:edge
LABEL maintainer="https://keybase.io/tcely"

ENV PAGER=less

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 53/tcp 53/udp

RUN apk --update add \
        less man \
        bash ca-certificates \
        bind bind-tools bind-doc \
        && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

RUN chmod -c a+rx /entrypoint.sh && \
    chmod -c g-w /var/bind && \
    cp -p /etc/bind/bind.keys /var/bind/ && \
    ln -s ../../var/run/named/rndc.key /etc/bind/rndc.key

# /var/cache/bind needs to be owned by "bind"
# since we are mounting, do it manually
# NOTE: Per Dockerfile manual --> need to mkdir the mounted dir to chown
RUN mkdir -m 0755 -p /var/run/named /var/cache/bind && \
    : >> /var/cache/bind/docker-init && \
    chown -R root:named /var/run/named && \
    chown -R named:named /var/cache/bind

# Mounts
# NOTE: Per Dockerfile manual -->
#	"if any build steps change the data within the volume
# 	 after it has been declared, those changes will be discarded."
VOLUME ["/etc/bind", "/var/cache/bind"]
