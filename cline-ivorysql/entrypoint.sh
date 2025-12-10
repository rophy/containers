#!/bin/sh

set -e

# Define desired UID and GID from environment variable, defaults to 1000:1000.
NEW_UID=${HOST_UID:-1000}
NEW_GID=${HOST_GID:-1000}
TARGET_USER="node"

groupmod --gid "$NEW_GID" "$TARGET_USER"
usermod --uid "$NEW_UID" --gid "$NEW_GID" "$TARGET_USER"

# Copy AGENT.md to working directory if it exists
if [ -f /AGENT.md ]; then
    cp /AGENT.md "${PWD}/AGENT.md" 2>/dev/null || true
    chown "$NEW_UID:$NEW_GID" "${PWD}/AGENT.md" 2>/dev/null || true
fi

exec gosu "$TARGET_USER" "$@"

