FROM tcely/alpine-aports:builder AS builder
LABEL maintainer="https://keybase.io/tcely"

ENV aport_subdir='main/bind'

RUN abuild-keygen -ain

RUN git clone --depth=10 --branch "${GH_BRANCH}" "${GH_REPO}"

RUN cd "aports/${aport_subdir}" && \
    abuild -K -r && checkapk

