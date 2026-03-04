#!/bin/bash

set -u
STATE_DIR="${STATE_DIR:-/opt/mini-deploy/state}"
source "$STATE_DIR/config.env"
response=$(curl -s "$HEALTH_URL")

echo "$response" | grep -q "dongho"



