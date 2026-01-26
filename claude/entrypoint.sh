#!/bin/sh

set -e

# Define desired UID and GID from environment variable, defaults to 1000:1000.
HOST_UID=${HOST_UID:-1000}
HOST_GID=${HOST_GID:-1000}
DOCKER_GID=${DOCKER_GID:-999}
GOSU_USER=${GOSU_USER:-claude}
WELCOME_MSG=${WELCOME_MSG:-"Run 'claude' to start Claude Code."}

groupmod --gid ${HOST_GID} ${GOSU_USER} > /dev/null
usermod --uid ${HOST_UID} --gid ${HOST_GID} ${GOSU_USER} > /dev/null
groupmod -g ${DOCKER_GID} docker > /dev/null

echo "${WELCOME_MSG}"
exec gosu ${GOSU_USER} "$@"

