#!/bin/bash

source config.cfg

source slack_webhook.sh
source check_disk_used.sh



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




check_disk_used
