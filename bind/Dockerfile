FROM alpine:edge

COPY entrypoint.sh /
EXPOSE 53 53/udp
ENTRYPOINT ["/entrypoint.sh"]

RUN apk --update upgrade && apk add bind && rm -rf /var/cache/apk/*

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
