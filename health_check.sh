#!/bin/bash
set -euo pipefail

TARGET="${1:-}"

if [ "$TARGET" != "blue" ] && [ "$TARGET" != "green" ]; then
 echo "usage: ./health_check.sh blue|green"
 exit 1

fi
 
CONTAINER="py-backend-$TARGET"
TMOUT=30
INTERVAL=2
ELAPSED=0

while [ "$ELAPSED" -lt "$TMOUT" ]; do

 STATUS=$(docker inspect -f '{{.State.Health.Status}}' "$CONTAINER" 2>/dev/null || echo "not found container") 
 if [ "$STATUS" = "healthy" ]; then 
  echo "[HEALTH_CHECK] $CONTAINER IS HEALTHY"
  exit 0 
 fi
 
 sleep "$INTERVAL"
 ELAPSED=$((ELAPSED+INTERVAL))
done

echo "[HEALTH_CHECK] $CONTAINER IS NOT HEALTHY"
exit 1






