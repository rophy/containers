#!/bin/sh

set -e

# Define desired UID and GID from environment variable, defaults to 1000:1000.
HOST_UID=${HOST_UID:-1000}
HOST_GID=${HOST_GID:-1000}
DOCKER_GID=${DOCKER_GID:-999}
TARGET_USER="cline"

groupmod --gid ${HOST_GID} ${TARGET_USER}
usermod --uid ${HOST_UID} --gid ${HOST_GID} ${TARGET_USER}
groupmod -g ${DOCKER_GID} docker

exec gosu ${TARGET_USER} "$@"

