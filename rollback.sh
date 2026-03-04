#!/bin/bash
STATE_DIR="${STATE_DIR:-/opt/mini-deploy/state}"
source "$STATE_DIR/config.env"
ACTIVE_VERSION=$(cat "$STATE_DIR/active_version.txt")
PRE_VERSION=$((ACTIVE_VERSION - 1))
echo "[ROLLBACK] rollbackcall"


docker stop $CONTAINER_NAME || true

docker rm $CONTAINER_NAME || true

docker run -d -p $HOST_PORT:$CONTAINER_PORT --name $CONTAINER_NAME $IMAGE_NAME:$PRE_VERSION



