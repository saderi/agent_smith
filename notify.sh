#!/bin/bash

function slack_webhook  {
    SLACK_WEBHOOK_MESSAGE=$1
    curl -X POST \
    --data-urlencode "payload={\"channel\": \"$SLACK_WEBHOOK_CHANNEL\", \"text\": \"$SLACK_WEBHOOK_MESSAGE\"}" \
    $SLACK_WEBHOOK_URL
}


function sms_clickatell  {
    curl "https://platform.clickatell.com/messages/http/send?apiKey=$CLICKATELL_API_KEY&to=$SMS_RECEPTOR&content=$MESSAGE"
}


function sms_kavenegar  {
    curl --request POST \
         --url http://api.kavenegar.com/v1/$KAVENEGAR_API_KEY/sms/send.json \
         --header 'cache-control: no-cache' \
         --header 'content-type: application/x-www-form-urlencoded' \
         --data "receptor=$SMS_RECEPTOR&message=$MESSAGE"

}


function send_sms  {
    MESSAGE=$1
    sms_$ACTIVE_SMS_GATEWAY $MESSAGE
}