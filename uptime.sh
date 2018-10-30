#!/bin/bash

ALERT_LIMIT=5


UPTIME=$(uptime  | grep -oP '(?<=average: ).*' | tr "," "\n" | tr "m" "\n" )
UPTIME_ARRAY=(`echo $UPTIME | tr "," "\n"`)

if [ ${UPTIME_ARRAY[0]%.*} -gt 2 ]; then
	echo "OK"
fi
