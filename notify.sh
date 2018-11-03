#!/bin/bash

function slack_webhook  {
    SLACK_WEBHOOK_MESSAGE=$1
    curl -X POST \
    --data-urlencode "payload={\"channel\": \"$SLACK_WEBHOOK_CHANNEL\", \"text\": \"$SLACK_WEBHOOK_MESSAGE\"}" \
    $SLACK_WEBHOOK_URL
}


function send_sms_clickatell  {
    MESSAGE=$1
    curl "https://platform.clickatell.com/messages/http/send?apiKey=$CLICKATELL_API_KEY&to=$SMS_RECEPTOR&content=$MESSAGE"
}
