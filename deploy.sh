#!/bin/bash

set -u
source ./config.env

#scp "$SRC_FILE" root@"$TARGET_HOST":"$DEST_PATH" || exit 1
#ssh root@"$TARGET_HOST" "systemctl restart nginx" || exit 1

scp $SRC_FILE root@$TARGET_HOST:$DEST_PATH
if [ $? -ne 0 ]; then
	exit 1
fi

ssh root@$TARGET_HOST "systemctl restart nginx"
if [ $? -ne 0 ]; then
	exit 1
fi



