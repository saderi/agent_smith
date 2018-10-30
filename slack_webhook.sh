#!/bin/bash

function slack_webhook {
    SLACK_WEBHOOK_MESSAGE="Disk Usage Warning. Disk used over $USED%"
    curl -X POST \
    --data-urlencode "payload={\"channel\": \"$SLACK_WEBHOOK_CHANNEL\", \"text\": \"$SLACK_WEBHOOK_MESSAGE\"}" \
    $SLACK_WEBHOOK_URL
}
