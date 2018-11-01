#!/bin/bash

function uptime_check {

    UPTIME=$(uptime  | grep -oP '(?<=average: ).*' | tr "," "\n" | tr "m" "\n" )
    UPTIME_ARRAY=(`echo $UPTIME | tr "," "\n"`)

    if [ ${UPTIME_ARRAY[0]%.*} -gt $ALERT_LIMIT ]; then
        slack_webhook "Over Uptime ${UPTIME_ARRAY[0]}"
    fi

}