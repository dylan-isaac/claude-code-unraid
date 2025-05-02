#!/bin/bash

# Build and publish Docker image for Claude Code Unraid container
# Usage: ./build.sh [tag]

# Default tag is latest
TAG=${1:-latest}

# Get directory of script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change to script directory
cd "$DIR"

echo "Building Claude Code Unraid container with tag: $TAG"

# Build Docker image
docker build -t dylanisaac/claude-code-unraid:$TAG .

echo "Build complete! To push to Docker Hub, run:"
echo "docker login"
echo "docker push dylanisaac/claude-code-unraid:$TAG"