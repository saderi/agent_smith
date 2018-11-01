#!/bin/bash

source config.cfg
source slack_webhook.sh

function get_last_alert {
    NOW=$(date +"%s")
    if [ -s "/tmp/.alert-time" ]
    then
        LAST_ALERT=$(cat /tmp/.alert-time)
    else 
        LAST_ALERT=0
    fi
    INTERVAL=$(($NOW - $LAST_ALERT))
}

# Run check disk function
source checkers/disk_used_check.sh
disk_used_check

# Run uptime function
source checkers/uptime_check.sh
uptime_check