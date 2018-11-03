#!/bin/bash

function disk_used_check {
    get_last_alert
    cd $TARGET_DIR
    #Get used space of partition where we currently.
    USED=`df $TARGET_FILESYSTEM | awk '{print $5}' | sed -ne 2p | cut -d"%" -f1`

    #If used space is bigger than DISK_OVER_QUOTA_LIMIT
    if [ $USED -gt $DISK_OVER_QUOTA_LIMIT ] && [ $INTERVAL -gt $ALERT_TIME ]
    then
        echo $NOW > /tmp/.alert-time
        slack_webhook "Disk Usage Warning. Disk used over $USED%"
    fi
}


function uptime_check {
    get_last_alert
    UPTIME=$(uptime  | grep -oP '(?<=average: ).*' | tr "," "\n" | tr "m" "\n" )
    UPTIME_ARRAY=(`echo $UPTIME | tr "," "\n"`)

    if [ ${UPTIME_ARRAY[0]%.*} -gt $OVER_UPTIME ] && [ $INTERVAL -gt $ALERT_TIME ]
    then
        echo $NOW > /tmp/.alert-time
        slack_webhook "Over Uptime ${UPTIME_ARRAY[0]}%"
        send_sms_clickatell "High+1+minute+load+average+alert+${UPTIME_ARRAY[0]}%"
    fi

}


