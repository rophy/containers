FROM node:22-bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    gosu \
    sudo \
    tini \
    && rm -rf /var/lib/apt/lists/*

# Install docker-cli
RUN curl -fsSL https://download.docker.com/linux/debian/dists/bookworm/pool/stable/amd64/docker-ce-cli_29.1.3-1~debian.12~bookworm_amd64.deb -o /tmp/docker-ce-cli.deb \
    && dpkg -i /tmp/docker-ce-cli.deb \
    && rm /tmp/docker-ce-cli.deb \
    && npm install -g cline

RUN usermod -l cline -d /home/cline -m node \
    && groupmod -n cline node \
    && groupadd docker \
    && usermod -aG docker,sudo cline \
    && echo 'cline ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/cline

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/entrypoint.sh"]

CMD ["bash"]
