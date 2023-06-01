FROM alpine:latest

RUN apk add --no-cache curl

WORKDIR /workspace

ENV VERSION=v4.5.1
RUN curl -fsSL -o podman-linux-amd64.tar.gz https://github.com/mgoltzsche/podman-static/releases/download/$VERSION/podman-linux-amd64.tar.gz \

# RUN tar -xzf podman-linux-amd64.tar.gz && cp -r podman-linux-amd64/usr podman-linux-amd64/etc /

