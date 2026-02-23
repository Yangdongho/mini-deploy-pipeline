#!/bin/bash

set -u
source ./config.env
REMOTE_FILE="${DEST_PATH%/}/$(basename "$SRC_FILE")"

#배포전 백업
ssh -o BatchMode=yes -o StrictHostKeyChecking=accept-new \
  "root@${TARGET_HOST}" \
  "test -f '${REMOTE_FILE}' && cp -f '${REMOTE_FILE}' '${REMOTE_FILE}.bak' || true"

scp -o BatchMode=yes -o StrictHostKeyChecking=accept-new \
  "$SRC_FILE" "root@${TARGET_HOST}:${REMOTE_FILE}" || exit 1

ssh -o BatchMode=yes -o StrictHostKeyChecking=accept-new \
  "root@${TARGET_HOST}" "systemctl restart nginx" || exit 1

