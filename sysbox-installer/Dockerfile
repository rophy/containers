FROM cgr.dev/chainguard/wolfi-base

ARG SYSBOX_VERSION=0.7.1
ARG TARGETARCH

ADD https://github.com/nestybox/sysbox/releases/download/v${SYSBOX_VERSION}/sysbox-ce_${SYSBOX_VERSION}.linux_${TARGETARCH}.deb /sysbox-ce.deb

ENTRYPOINT ["echo", "To extract the installer, run:\n  docker create --name sysbox <image>\n  docker cp sysbox:/sysbox-ce.deb .\n  docker rm sysbox"]
