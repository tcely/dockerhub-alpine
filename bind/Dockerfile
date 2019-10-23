FROM tcely/alpine-aports AS builder
LABEL maintainer="https://keybase.io/tcely"

ENV aport_subdir='main/bind'
ENV GH_BRANCH='bleeding' GH_REPO='https://github.com/tcely/aports.git'

RUN apk --update add \
        alpine-sdk lua-aports

RUN printf >> /etc/abuild.conf -- \
        'JOBS=%d\n' "$(nproc --ignore=1)" \
        && \
    printf >> /etc/abuild.conf -- \
        'MAKEFLAGS=-j${JOBS}\n'

RUN printf > /etc/sudoers.d/wheel -- \
        '%%%s ALL=(ALL) NOPASSWD: ALL\n' wheel

ENV USER='buildozer' HOME='/home/buildozer'
RUN adduser -D "${USER}" && \
    addgroup "${USER}" abuild && \
    addgroup "${USER}" wheel && \
    install -d -g abuild -m 775 /var/cache/distfiles

USER "${USER}"
WORKDIR "${HOME}"

RUN abuild-keygen -ain

RUN git clone --depth=10 --branch "${GH_BRANCH}" "${GH_REPO}"

RUN cd "aports/${aport_subdir}" && \
    abuild -K -r && checkapk

FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 53/tcp 53/udp

COPY --from=builder /etc/apk/keys /etc/apk/keys
COPY --from=builder /home/buildozer/packages /var/cache/apk-packages
RUN printf >> /etc/apk/repositories -- \
        '%s\n' /var/cache/apk-packages/*

RUN apk --update add \
        bash ca-certificates \
        bind bind-plugins bind-tools bind-doc \
        && \
    rm -rf /var/cache/apk/*

RUN chmod -c a+rx /entrypoint.sh && \
    cp -p /etc/bind/bind.keys /var/bind/ && \
    ln -f -s ../../var/run/named/rndc.key /etc/bind/rndc.key

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
VOLUME ["/etc/bind", "/var/bind", "/var/cache/bind"]
