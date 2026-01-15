#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

if [ -z "$1" ]; then
    echo "Usage: $0 <container-folder-name>"
    echo "Example: $0 aws-cli"
    exit 1
fi

FOLDER_NAME="$1"
FOLDER_PATH="$ROOT_DIR/$FOLDER_NAME"

if [ ! -d "$FOLDER_PATH" ]; then
    echo "Error: Directory '$FOLDER_PATH' does not exist"
    exit 1
fi

if [ ! -f "$FOLDER_PATH/Dockerfile" ]; then
    echo "Error: No Dockerfile found in '$FOLDER_PATH'"
    exit 1
fi

IMAGE_NAME="${FOLDER_NAME}:latest"

echo "Building $IMAGE_NAME from $FOLDER_PATH"
docker build -t "$IMAGE_NAME" "$FOLDER_PATH"

echo "Successfully built $IMAGE_NAME"
