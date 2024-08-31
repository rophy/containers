FROM alpine:3.20.2

RUN apk add --no-cache curl && \
    curl -fL -o /usr/local/bin/skaffold "https://storage.googleapis.com/skaffold/releases/v2.13.2/skaffold-linux-amd64" && \
    chmod a+x /usr/local/bin/skaffold

CMD ["/usr/local/bin/skaffold"]


