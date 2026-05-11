#!/bin/bash
set -e

REGISTRY=${REGISTRY:?"REGISTRY env var required"}
TAG=${TAG:-$(git rev-parse --short HEAD)}

echo "Deploying PatchGuard (tag: $TAG)..."
pytest tests/ -x -q

docker build -t "$REGISTRY/patchguard:$TAG" -f docker/Dockerfile .
docker tag "$REGISTRY/patchguard:$TAG" "$REGISTRY/patchguard:latest"
docker push "$REGISTRY/patchguard:$TAG"
docker push "$REGISTRY/patchguard:latest"

echo "Done. Image: $REGISTRY/patchguard:$TAG"
