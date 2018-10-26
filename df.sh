#!/bin/bash

TARGET_DIR='/var' # Set directory for cheack disk used 
DISK_OVER_QUOTA_LIMIT=10 # Set limit for starting send alert, Defualt is 90%
ALERT_TIME=20 # delay between alert (Second)
SLACK_WEBHOOK_CHANNEL='#alert-server'
SLACK_WEBHOOK_URL='https://hooks.slack.com/services/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'


function slack_webhook {
    
    SLACK_WEBHOOK_MESSAGE="Disk Usage Warning. Disk used over $USED%"
    curl -X POST \
    --data-urlencode "payload={\"channel\": \"$SLACK_WEBHOOK_CHANNEL\", \"text\": \"$SLACK_WEBHOOK_MESSAGE\"}" \
    $SLACK_WEBHOOK_URL

}

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

}


check_disk_used
