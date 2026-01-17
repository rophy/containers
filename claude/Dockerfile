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
      man-db \
      nano \
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
    && rm -rf /var/lib/apt/lists/*

# kubectl
ARG KUBECTL_VERSION=v1.35.0
RUN curl -fsSL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# helm
ARG HELM_VERSION=v4.0.4
RUN curl -fsSL "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" | tar xz -C /tmp && \
    mv /tmp/linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    rm -rf /tmp/linux-amd64

# aws cli
RUN curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip && \
    unzip -q /tmp/awscliv2.zip -d /tmp && \
    /tmp/aws/install && \
    rm -rf /tmp/aws /tmp/awscliv2.zip

# docker-cli
RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo 'Types: deb' > /etc/apt/sources.list.d/docker.sources && \
    echo 'URIs: https://download.docker.com/linux/debian' >> /etc/apt/sources.list.d/docker.sources && \
    bash -c '. /etc/os-release && echo "Suites: ${UBUNTU_CODENAME:-$VERSION_CODENAME}"' >> /etc/apt/sources.list.d/docker.sources && \
    echo 'Components: stable' >> /etc/apt/sources.list.d/docker.sources && \
    echo 'Signed-By: /etc/apt/keyrings/docker.asc' >> /etc/apt/sources.list.d/docker.sources && \
    apt-get update && \
    apt-get install -y --no-install-recommends docker-ce-cli docker-buildx-plugin docker-compose-plugin && \
    rm -rf /var/lib/apt/lists/*

RUN usermod -l claude -d /home/claude -m node \
    && groupmod -n claude node \
    && groupadd docker \
    && usermod -aG docker,sudo claude \
    && echo 'claude ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/claude

RUN cat > /etc/profile.d/devcontainer.sh << 'EOF'
# Prompt
set_prompt() {
    if [ $? -eq 0 ]; then
        COLOR="\[\e[32m\]" # Green for success
    else
        COLOR="\[\e[31m\]" # Red for error
    fi
    PS1="${COLOR}\u@DEVCONTAINER\[\e[0m\]:\w\$ "
}
PROMPT_COMMAND=set_prompt

# Aliases
alias claude="claude --dangerously-skip-permissions"
alias dc="docker compose"

# Enable bash-completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi
EOF

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/entrypoint.sh"]

CMD ["bash", "-l"]
