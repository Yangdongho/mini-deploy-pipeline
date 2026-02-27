#!/bin/bash
set -e

source ./config.env
VERSION=$(cat version.txt)

echo "[DEPLOY-DOCKER] build image"
docker build -t $IMAGE_NAME:$VERSION .

docker tag $IMAGE_NAME:$VERSION $IMAGE_NAME:latest

echo "[DEPLOY-DOCKER] old container"
docker stop $CONTAINER_NAME || true

echo "[DEPLOY-DOCKER] remove old container"
docker rm $CONTAINER_NAME || true

echo "[DEPLOY-DOCKER] run docker"
docker run -d -p 8080:80 --name $CONTAINER_NAME $IMAGE_NAME:$VERSION


echo "FINISH DEPLOY-DOCKER...."

