FROM alpine/git:latest AS tap
RUN git clone --depth 1 https://github.com/openai/homebrew-tools.git /tap

FROM busybox

ARG TART_VERSION=2.36.0
ARG SOFTNET_VERSION=0.23.0

ADD https://github.com/openai/tart/releases/download/${TART_VERSION}/tart.tar.gz /shipper/binaries/tart.tar.gz
ADD https://github.com/openai/softnet/releases/download/${SOFTNET_VERSION}/softnet.tar.gz /shipper/binaries/softnet.tar.gz

COPY --from=tap /tap /shipper/tap
COPY rewrite-urls.sh /shipper/rewrite-urls.sh
COPY README.md /shipper/README.md

ENTRYPOINT ["cat", "/shipper/README.md"]
