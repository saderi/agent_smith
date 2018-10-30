#!/bin/bash

function check_disk_used {
    get_last_alert
    cd $TARGET_DIR
    #Get used space of partition where we currently.
    USED=`df . | awk '{print $5}' | sed -ne 2p | cut -d"%" -f1`

    #If used space is bigger than DISK_OVER_QUOTA_LIMIT
    if [ $USED -gt $DISK_OVER_QUOTA_LIMIT ] && [ $INTERVAL -gt $ALERT_TIME ]
    then
        echo $NOW > /tmp/.alert-time
        slack_webhook
    fi
    echo $USED
}
