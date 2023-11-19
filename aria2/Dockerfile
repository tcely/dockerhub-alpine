FROM tcely/alpine-aports
LABEL maintainer="https://keybase.io/tcely"

RUN apk --update add \
        ca-certificates \
        aria2 aria2-doc \
        && \
    rm -rf /var/cache/apk/*

ENV ARIA2DIR=/srv/aria2
ENV XDG_CACHE_HOME="${ARIA2DIR}/cache" XDG_CONFIG_HOME="${ARIA2DIR}/config"

WORKDIR "${ARIA2DIR}"
RUN mkdir -v -p cache && ln -v -s . cache/aria2 && \
    mkdir -v -p config && ln -v -s . config/aria2
    
VOLUME ["${ARIA2DIR}"]

# I'm not sure if this is better than SIGTERM.
# It is how I typically stop aria2c, so I'm keeping it.
# Stopping does tend to take a long time so, try:
# docker stop --time 600
# This waits up to 10 minutes for aria2c to exit cleanly,
# before sending the SIGKILL after the stop signal.
STOPSIGNAL SIGINT

# With the environment variables the default config path is now:
# "--conf-path=${ARIA2DIR:-.}/config/aria2/aria2.conf"
ENTRYPOINT ["/usr/bin/aria2c"]
CMD ["--help=#all"]
