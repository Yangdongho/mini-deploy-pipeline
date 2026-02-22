#!/bin/bash

set -u
source ./config.env

response=$(curl -s "$HEALTH_URL")

echo "$response" | grep -q "dongho"



