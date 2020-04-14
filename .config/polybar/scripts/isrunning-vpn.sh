#!/bin/sh

if [ "$(pgrep openvpn)" ]; then
    echo "嬨"
elif [ "$(pgrep wg)" ]; then
    echo "嬨"
else
    echo "ﮊ"
fi
