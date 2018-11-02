#!/bin/bash

function send_sms_clickatell  {
    MESSAGE=$1
    curl "https://platform.clickatell.com/messages/http/send?apiKey=$CLICKATELL_API_KEY&to=$SMS_RECEPTOR&content=$MESSAGE"
}
