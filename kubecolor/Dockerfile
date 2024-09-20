FROM busybox

RUN mkdir -p /tmp/build && \
	cd /tmp/build && \
    # kubectl
    wget https://dl.k8s.io/release/v1.31.1/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/bin/ && \
    # kubecolor
    wget -O kubecolor.tar.gz https://github.com/kubecolor/kubecolor/releases/download/v0.4.0/kubecolor_0.4.0_linux_amd64.tar.gz && \
    tar -zxf kubecolor.tar.gz && \
    cp ./kubecolor /usr/bin/ && \
    chmod +x /usr/bin/kubecolor && \
    rm -rf /tmp/build/

ENTRYPOINT ["/usr/bin/kubecolor"]
