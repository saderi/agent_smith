#!/bin/bash

# Send message with slack webhook
# Parametrs:
#       $SLACK_WEBHOOK_CHANNEL: set in config.cfg
#       $SLACK_WEBHOOK_MESSAGE: set when function called as first parametr
#       $SLACK_WEBHOOK_URL: set in config.cfg
function slack_webhook  {
    SLACK_WEBHOOK_MESSAGE=$1
    curl -X POST \
    --data-urlencode "payload={\"channel\": \"$SLACK_WEBHOOK_CHANNEL\", \"text\": \"$SLACK_WEBHOOK_MESSAGE\"}" \
    $SLACK_WEBHOOK_URL
}


# Send sms with clickatell.com API
# Parametrs:
#       $CLICKATELL_API_KEY: set in config.cfg
#       $SMS_RECEPTOR: set when function called as first parametr
#       $MESSAGE: set as first parametr when send_sms function called 
function sms_clickatell  {
    curl "https://platform.clickatell.com/messages/http/send?apiKey=$CLICKATELL_API_KEY&to=$SMS_RECEPTOR&content=$MESSAGE"
}


# Send sms with kavenegar.com API
# Parametrs:
#       $KAVENEGAR_API_KEY: set in config.cfg
#       $SMS_RECEPTOR: set in config.cfg
#       $MESSAGE: set as first parametr when send_sms function called 
function sms_kavenegar  {
    curl --request POST \
         --url http://api.kavenegar.com/v1/$KAVENEGAR_API_KEY/sms/send.json \
         --header 'cache-control: no-cache' \
         --header 'content-type: application/x-www-form-urlencoded' \
         --data "receptor=$SMS_RECEPTOR&message=$MESSAGE"

}


# This function chose witch sms gateway send sms.
# Parametrs:
#       $ACTIVE_SMS_GATEWAY: set in config.cfg
#       $SMS_MESSAGE: set as first parametr when this function called 
function send_sms  {

    #Replace space with '+' for sending sms.
    SMS_MESSAGE=$(echo $1 | sed -e 's/\ /+/g')
    sms_$ACTIVE_SMS_GATEWAY "$SMS_MESSAGE"
}


# This function chose witch notify gateway send mesaage.
# Parametrs:
#       $MESSAGE: set as first parametr when this function called
#       $NOTIFY_GATEWAY: choose notify gateway string parametr 
#                 'sms'   = message send only with sms
#                 'slack' = message send only with slack
#                 'all'   = message send only with slack and sms
function send_notify {
    MESSAGE=$1
    NOTIFY_GATEWAY=$2
    
    if [ $NOTIFY_GATEWAY = 'sms' ]
    then
        send_sms "$MESSAGE"
    elif [ $NOTIFY_GATEWAY = 'slack' ]
    then
        slack_webhook "$MESSAGE"
    elif [ $NOTIFY_GATEWAY = 'all' ]
    then
        send_sms "$MESSAGE"
        slack_webhook "$MESSAGE"
    fi
}