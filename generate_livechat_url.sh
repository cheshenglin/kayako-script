#!/bin/bash

#
# This script is used for generating Kayako LiveChat button with customized icon.
#

KAYAKO_BASE_URL="https://kayako.example.com/"
KAYAKO_LIVECHAT_BUTTON_PATH="visitor/index.php?/Default/LiveChat/HTML/HTMLButton/"
KAYAKO_INSTALL_HASH="your_install_hash"

ICON_URL="https://www.example.com/livechat_icon.png"
PRELOAD_PARAM="prompttype=chat&uniqueid=unique_id&version=4.70.2&product=fusion&filterdepartmentid=1&"

if [ "$1" != "" ]; then
    encoded_url=$(php -r "echo urlencode(\"$1\");")
else
    encoded_url=$(php -r "echo urlencode(\"$ICON_URL\");")
fi

full_parameters="${PRELOAD_PARAM}customonline=${encoded_url}&customoffline=${encoded_url}&customaway=${encoded_url}&custombackshortly=${encoded_url}"
# echo $full_parameters
# printf "\n"

signature=$(php -r "echo sha1(\"$full_parameters\" . \"$KAYAKO_INSTALL_HASH\");")
# echo $signature
# printf "\n"

# printf "=====\n"
newline=$'\n'
button_parameter="${full_parameters}${newline}${signature}"
# echo $button_parameter
# printf "\n"

encoded_button_parameter=$(php -r "echo base64_encode(\"$button_parameter\");")
echo $KAYAKO_BASE_URL$KAYAKO_LIVECHAT_BUTTON_PATH$encoded_button_parameter
printf "\n"
