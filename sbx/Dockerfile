FROM cgr.dev/chainguard/wolfi-base

ARG SBX_VERSION=0.39.0
ADD https://github.com/docker/sbx-releases/releases/download/v${SBX_VERSION}/DockerSandboxes-linux-amd64-ubuntu2404.deb /DockerSandboxes-linux-amd64-ubuntu2404.deb
ENTRYPOINT ["echo", "To extract the installer, run:\n  docker create --name sbx <image>\n  docker cp sbx:/DockerSandboxes-linux-amd64-ubuntu2404.deb .\n  docker rm sbx"]
