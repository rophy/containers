#!/bin/sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
IMAGE_NAME="cline-cli:latest"

# Build base image if it doesn't exist
if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
  echo "Image $IMAGE_NAME not found, building..."
  docker build -t "$IMAGE_NAME" "$SCRIPT_DIR"
fi

# https://stackoverflow.com/a/687052
tmpdir="$(mktemp -d)"
trap 'rm -rf -- "$tmpdir"' EXIT

cat <<EOF > "${tmpdir}/Dockerfile"
# You can customize image here.
FROM ${IMAGE_NAME}
EOF

docker build -t cline "${tmpdir}"

HOST_UID=$(id -u)
HOST_GID=$(id -g)
DOCKER_GID=$(getent group docker | cut -d: -f3)
WORKDIR=$(pwd)

docker run --rm -it \
  -e HOST_UID=${HOST_UID} \
  -e HOST_GID=${HOST_GID} \
  -e DOCKER_GID=${DOCKER_GID} \
  -v "/var/run/docker.sock:/var/run/docker.sock:ro" \
  -v "${HOME}:/home/cline" \
  -v "${WORKDIR}:${WORKDIR}" \
  --workdir="${WORKDIR}" \
  cline
