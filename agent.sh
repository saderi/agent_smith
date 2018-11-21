#!/bin/bash

source config.cfg
source notify.sh
source checkers.sh

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

# Run uptime function
uptime_check

# Run check disk function
disk_used_check

# Run connaction counter function
connaction_count