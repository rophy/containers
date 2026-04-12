FROM gitlab/gitlab-runner:alpine-v18.10.1

USER root

RUN apk add --no-cache \
      ansible \
      jq \
      openssl \
      python3 \
      py3-pip \
      yq

# kubectl
RUN curl -fsSL "https://dl.k8s.io/release/v1.35.3/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# helm
RUN curl -fsSL "https://get.helm.sh/helm-v4.1.4-linux-amd64.tar.gz" | tar xz -C /tmp && \
    mv /tmp/linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    rm -rf /tmp/linux-amd64
