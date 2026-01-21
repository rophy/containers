FROM node:22-bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      bash-completion \
      ca-certificates \
      curl \
      fuse-overlayfs \
      fzf \
      git \
      gnupg2 \
      gosu \
      jq \
      less \
      make \
      man-db \
      nano \
      openssh-client \
      procps \
      python3 \
      python3-jinja2 \
      slirp4netns \
      sudo \
      tini \
      uidmap \
      unzip \
      vim \
      wget \
      yq \
    && rm -rf /var/lib/apt/lists/*

COPY etc/apt /etc/apt

# docker-cli
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      docker-buildx-plugin \
      docker-ce-cli \
      docker-compose-plugin \
    && rm -rf /var/lib/apt/lists/*

# kubectl
RUN curl -fsSL "https://dl.k8s.io/release/v1.35.0/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# helm
RUN curl -fsSL "https://get.helm.sh/helm-v4.0.4-linux-amd64.tar.gz" | tar xz -C /tmp && \
    mv /tmp/linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    rm -rf /tmp/linux-amd64

# aws cli
RUN curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/aws /tmp/awscliv2.zip

# terraform
RUN curl -fsSL "https://releases.hashicorp.com/terraform/1.14.3/terraform_1.14.3_linux_amd64.zip" -o terraform.zip && \
    unzip -q terraform.zip -d /usr/local/bin && \
    rm terraform.zip

# kind
RUN curl -fsSL "https://github.com/kubernetes-sigs/kind/releases/latest/download/kind-linux-amd64" -o /usr/local/bin/kind && \
    chmod +x /usr/local/bin/kind

# minikube
RUN curl -fsSL "https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64" -o /usr/local/bin/minikube && \
    chmod +x /usr/local/bin/minikube

# github cli
RUN curl -fsSL "https://github.com/cli/cli/releases/download/v2.86.0/gh_2.86.0_linux_amd64.tar.gz" | tar xz -C /tmp && \
    mv /tmp/gh_2.86.0_linux_amd64/bin/gh /usr/local/bin/gh && \
    chmod +x /usr/local/bin/gh && \
    rm -rf /tmp/gh_2.86.0_linux_amd64

# claude
RUN npm install -g @anthropic-ai/claude-code happy-coder

# rename "node" user to "claude"
RUN usermod -l claude -d /home/claude -m node \
    && groupmod -n claude node \
    && groupadd docker \
    && usermod -aG docker,sudo claude \
    && echo 'claude ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/claude

COPY etc/profile.d /etc/profile.d
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/entrypoint.sh"]

CMD ["bash", "-l"]

