FROM debian:bookworm-20240722-slim

# docker-cli
ADD https://download.docker.com/linux/debian/dists/bookworm/pool/stable/amd64/docker-ce-cli_27.1.1-1~debian.12~bookworm_amd64.deb /tmp
RUN dpkg -i /tmp/docker-ce-cli_27.1.1-1~debian.12~bookworm_amd64.deb && \
    rm -rf /tmp/*

# cloud-provider-kind
ADD https://github.com/kubernetes-sigs/cloud-provider-kind/releases/download/v0.3.0/cloud-provider-kind_0.3.0_linux_amd64.tar.gz /tmp
RUN tar -C /tmp -zxf /tmp/cloud-provider-kind_0.3.0_linux_amd64.tar.gz && \
    cp /tmp/cloud-provider-kind /usr/local/bin/ && \
    rm -rf /tmp/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/local/bin/cloud-provider-kind"]
