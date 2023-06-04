FROM node:18.16.0-bullseye

WORKDIR /opt/cronicle/

ENV CRONICLE_VERSION=0.9.23

RUN apt-get update && apt-get install -y --no-install-recommends git curl bash

RUN curl -sL "https://github.com/jhuckaby/Cronicle/archive/v${CRONICLE_VERSION}.tar.gz" | tar zxf - --strip-components 1 \
    && npm install \
    && node bin/build.js dist

ENV NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
