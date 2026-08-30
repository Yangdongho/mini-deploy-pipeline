#!/bin/bash
set -eou pipefail

echo "[DEPLOY] start blue-green deploy"

ACTIVE_LINK=$(docker exec nginx-proxy readlink /etc/nginx/conf.d/upstream.conf)

echo "[DEPLOY] current upstream=$ACTIVE_LINK"

if echo "$ACTIVE_LINK" | grep -q "upstream.blue"; then
  ACTIVE="blue"
  TARGET="green"
elif echo "$ACTIVE_LINK" | grep -q "upstream.green"; then
  ACTIVE="green"
  TARGET="blue"
else
  echo "[DEPLOY] unknown active upstream"
  exit 1
fi

VERSION=${GITHUB_SHA:-$(date +%Y%m%d-%H%M)}
IMAGE_TAG="localhost:5000/mini-backend:$VERSION"

echo "[DEPLOY] active=$ACTIVE target=$TARGET"

echo "[DEPLOY] build image = $IMAGE_TAG"
docker build -t $IMAGE_TAG ./backend

echo "[DEPLOY] push image = $IMAGE_TAG"
docker push $IMAGE_TAG

echo "[DEPLOY] pull image = $IMAGE_TAG"
docker pull "$IMAGE_TAG"

echo "[DEPLOY] start target backend: $TARGET"
BACKEND_IMAGE=$IMAGE_TAG docker compose -p deploy-test up -d --force-recreate backend-$TARGET

echo "[DEPLOY] wait healthcheck: $TARGET"
./health_check.sh $TARGET

echo "[DEPLOY] switch traffic to: $TARGET"
./switch.sh $TARGET

echo "[DEPLOY] stop old backend: $ACTIVE"
docker compose -p deploy-test stop backend-$ACTIVE

echo "[DEPLOY] deploy complete active=$TARGET"



