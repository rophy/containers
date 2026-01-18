#!/bin/sh

set -e

IMAGE_NAME="claude:latest"

HOST_UID=$(id -u)
HOST_GID=$(id -g)
DOCKER_GID=$(getent group docker | cut -d: -f3)
WORKDIR=$(pwd)

docker run --rm -it \
  -e DEV_CONTAINER=true \
  -e HOST_UID=${HOST_UID} \
  -e HOST_GID=${HOST_GID} \
  -e DOCKER_GID=${DOCKER_GID} \
  -v "/var/run/docker.sock:/var/run/docker.sock:ro" \
  -v "${HOME}/.devcontainer:/home/claude" \
  -v "${WORKDIR}:${WORKDIR}" \
  --workdir="${WORKDIR}" \
  claude
