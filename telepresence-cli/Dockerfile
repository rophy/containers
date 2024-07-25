FROM debian:bullseye-20240722-slim

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fL "https://dl.k8s.io/release/v1.30.3/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl && \
    curl -fL "https://app.getambassador.io/download/tel2oss/releases/download/v2.17.0/telepresence-linux-amd64" -o /usr/local/bin/telepresence && \
    chmod a+x /usr/local/bin/telepresence && \
    chmod a+x /usr/local/bin/kubectl

CMD ["/usr/local/bin/telepresence"]


