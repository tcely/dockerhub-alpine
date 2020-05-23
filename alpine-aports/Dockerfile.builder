FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

ENV GH_BRANCH='bleeding' GH_REPO='https://github.com/tcely/aports.git'
ENV USER='buildozer' HOME='/home/buildozer'

RUN apk --update add \
        alpine-sdk lua-aports

RUN printf >> /etc/abuild.conf -- \
        'JOBS="$(nproc --ignore=1)"\nMAKEFLAGS="-j${JOBS}"\n'

RUN printf > /etc/sudoers.d/wheel -- \
        '%%%s ALL=(ALL) NOPASSWD: ALL\n' wheel

RUN adduser -D "${USER}" && \
    addgroup "${USER}" abuild && \
    addgroup "${USER}" wheel && \
    install -d -g abuild -m 775 /var/cache/distfiles

COPY abuild.patch /var/cache/distfiles/
COPY gpg_signatures.sh /usr/share/abuild/

RUN apk --update add \
        abuild gnupg patch && \
    patch -p 1 -i /var/cache/distfiles/abuild.patch "$(command -v abuild)"

USER "${USER}"
WORKDIR "${HOME}"
