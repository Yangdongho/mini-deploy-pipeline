#!/bin/bash


SERVER_IP=172.20.10.7
response=$(curl -s http://$SERVER_IP)


echo "$response" | grep "dongho" > /dev/null 2>&1

if [ $? -eq 0 ]; then
	exit 0

else 
	exit 1
fi





