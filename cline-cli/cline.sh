#!/bin/sh

set -e

# https://stackoverflow.com/a/687052
tmpdir="$(mktemp -d)"
trap 'rm -rf -- "$tmpdir"' EXIT


cat <<EOF > "${tmpdir}/Dockerfile"
# You can customize image here.
FROM rophy/containers/cline
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

