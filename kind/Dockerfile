FROM busybox:musl
ENV KIND_VERSION v0.17.0
ADD https://github.com/kubernetes-sigs/kind/releases/download/${KIND_VERSION}/kind-linux-amd64 /kind
RUN chmod +x /kind
ENTRYPOINT ["/kind"]
