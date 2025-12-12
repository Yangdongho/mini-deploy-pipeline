#!/bin/bash

SERVER_IP=172.20.10.7
DEST_PATH=/usr/share/nginx/html/
SRC_FILE=/root/deploy-test/index.html
LOG="./deploy.log"


scp $SRC_FILE root@$SERVER_IP:$DEST_PATH
if [ $? -ne 0 ]; then
	exit 1
fi

ssh root@$SERVER_IP "systemctl restart nginx"
if [ $? -ne 0 ]; then
	exit 1
fi



