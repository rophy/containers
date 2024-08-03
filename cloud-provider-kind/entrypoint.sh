#!/bin/sh
set -e

if [ ! -f "/var/run/docker.sock" ]; then
    2>&1 echo "WARNING: /var/run/docker.sock is missing, cloud-provider-kind likely will not work."
    2>&1 echo "You are expected to start cloud-provider-kind container with:"
    2>&1 echo "  docker run --rm -it --network kind -v /var/run/docker.sock:/var/run/docker.sock cloud-provider-kind"
    2>&1 echo "See: https://github.com/kubernetes-sigs/cloud-provider-kind"
fi

exec "$@"
