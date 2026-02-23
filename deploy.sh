#!/bin/bash

set -u
source ./config.env
REMOTE_FILE="${DEST_PATH%/}/$(basename "$SRC_FILE")"

scp -o BatchMode=yes -o StrictHostKeyChecking=accept-new \
  "$SRC_FILE" "root@${TARGET_HOST}:${REMOTE_FILE}" || exit 1

ssh -o BatchMode=yes -o StrictHostKeyChecking=accept-new \
  "root@${TARGET_HOST}" "systemctl restart nginx" || exit 1

