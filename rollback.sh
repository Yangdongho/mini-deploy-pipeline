#!/bin/bash
source ./config.env

REMOTE_FILE="${DEST_PATH%/}/$(basename "$SRC_FILE")"
BACKUP_FILE="${REMOTE_FILE}.bak"

echo "call rollback"

ssh -o BatchMode=yes -o StrictHostKeyChecking=accept-new "root@${TARGET_HOST}" "test -f '${BACKUP_FILE}' && cp -f '${BACKUP_FILE}' '${REMOTE_FILE}' && systemctl restart nginx"

exit 0
