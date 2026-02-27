#!/bin/bash
source ./config.env

ACTIVE_VERSION=$(cat active_version.txt)
PRE_VERSION=$((ACTIVE_VERSION - 1))
echo "[ROLLBACK] rollbackcall"


docker stop $CONTAINER_NAME || true

docker rm $CONTAINER_NAME || true

docker run -d -p $HOST_PORT:$CONTAINER_PORT --name $CONTAINER_NAME $IMAGE_NAME:$PRE_VERSION



