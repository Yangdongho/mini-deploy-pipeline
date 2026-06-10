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

echo "[DEPLOY] active=$ACTIVE target=$TARGET"

echo "[DEPLOY] start target backend: $TARGET"
docker compose up -d --build backend-$TARGET

echo "[DEPLOY] wait healthcheck: $TARGET"
./health_check.sh $TARGET

echo "[DEPLOY] switch traffic to: $TARGET"
./switch.sh $TARGET

echo "[DEPLOY] stop old backend: $ACTIVE"
docker compose down backend-$ACTIVE

echo "[DEPLOY] deploy complete active=$TARGET"



