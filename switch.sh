#!/bin/bash
set -e

TARGET="${1:-}"

if [ "$TARGET" != "blue" ] && [ "$TARGET" != "green" ]; then
 echo "usage: ./switch.sh blue|green"
 exit 1

fi

docker exec nginx-proxy sh -c "ln -sfn /etc/nginx/conf.d/upstream.$TARGET /etc/nginx/conf.d/upstream.conf"
docker exec nginx-proxy nginx -t
docker exec nginx-proxy nginx -s reload


