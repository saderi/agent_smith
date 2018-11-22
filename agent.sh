#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"

source $DIR/config.cfg
source $DIR/notify.sh
source $DIR/checkers.sh

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

# Choose notify gateway with string parametr 
# 'sms'   = message send only with sms
# 'slack' = message send only with slack
# 'all'   = message send only with slack and sms

# Run uptime function
uptime_check "all"

# Run check disk function
disk_used_check "all"

# Run connaction counter function
connaction_count "slack"