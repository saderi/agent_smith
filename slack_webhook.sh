#!/bin/bash

function slack_webhook  {
    SLACK_WEBHOOK_MESSAGE=$1
    curl -X POST \
    --data-urlencode "payload={\"channel\": \"$SLACK_WEBHOOK_CHANNEL\", \"text\": \"$SLACK_WEBHOOK_MESSAGE\"}" \
    $SLACK_WEBHOOK_URL
}
