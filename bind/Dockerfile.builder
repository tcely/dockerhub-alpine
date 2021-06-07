FROM tcely/alpine-aports:builder AS builder
LABEL maintainer="https://keybase.io/tcely"

ENV aport_subdir='main/bind'

RUN abuild-keygen -ain

RUN git clone --depth=5 --branch "${GH_BRANCH}" "${GH_REPO}"

RUN cd aports/main/dns-root-hints && \
    abuild -K -r && checkapk

RUN cd "aports/${aport_subdir}" && \
    abuild -K -r && checkapk

