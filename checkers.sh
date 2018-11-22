#!/bin/bash

function disk_used_check {
    get_last_alert
    #Get used space of partition where we currently.
    USED=`df $TARGET_FILESYSTEM | awk '{print $5}' | sed -ne 2p | cut -d"%" -f1`

    #If used space is bigger than DISK_OVER_QUOTA_LIMIT
    if [ $USED -gt $DISK_OVER_QUOTA_LIMIT ] && [ $INTERVAL -gt $ALERT_TIME ]
    then
        echo $NOW > /tmp/.alert-time
        
        # Set and send message
        MESSAGE="Disk Usage Warning. Disk used over $USED%"
        send_notify "$MESSAGE" "$1"
    fi
}


function uptime_check {
    get_last_alert
    UPTIME=$(uptime  | grep -oP '(?<=average: ).*' | tr "," "\n" | tr "m" "\n" )
    UPTIME_ARRAY=(`echo $UPTIME | tr "," "\n"`)

    if [ ${UPTIME_ARRAY[0]%.*} -gt $OVER_UPTIME ] && [ $INTERVAL -gt $ALERT_TIME ]
    then
        echo $NOW > /tmp/.alert-time

        # Set and send message
        MESSAGE="High 1 minute load average alert ${UPTIME_ARRAY[0]}%"
        send_notify "$MESSAGE" "$1"
    fi

}


function connaction_count {
    get_last_alert
    CORRENT_COUNT=$(netstat -anp | grep ':443\|:80' | wc -l)

    if [ $CORRENT_COUNT -gt $CONNACTION_LIMIT ] && [ $INTERVAL -gt $ALERT_TIME ]
    then
        echo $NOW > /tmp/.alert-time
        HIGHEST_CONNECTIONS=$(netstat -anp | grep ':443\|:80' | awk '{print $5}' | \
        cut -d: -f1 | \
        sort | uniq -c | sort -n | \
        grep -v 0.0.0.0 | tail -6 | head -5)

        # Set and send message
        MESSAGE="Connections count is $CORRENT_COUNT.\n Highest number of connections:\n  $HIGHEST_CONNECTIONS"
        send_notify "$MESSAGE" "$1"
    fi
}
