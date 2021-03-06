#!/bin/bash

msg() {
    echo $1;
    notify-send --expire-time=3000 --app-name="Screenshot" $1;
}

FOLDER="$HOME/Public/Screenshots"
FILE="$FOLDER/$(date --iso-8601=seconds).png"

MSG_ERROR_ESCROTUM="escrotum not installed, please install it"

hash escrotum || (msg $MSG_ERROR_ESCROTUM && exit 1)

if [ "$1" == "--help" ]; then
    echo "Arguments:"
    echo "  --region"
    echo "  --fullscreen"
    exit 0
elif [ "$1" == "--region" ]; then
    echo "Doing a region shot!"
    escrotum --select $FILE
    msg "Captured region"
elif [ "$1" == "--fullscreen" ]; then
    escrotum $FILE
    msg "Captured fullscreen"
else
    echo "Needs a command line argument, see --help for info."
    exit 1
fi
xclip -sel clip -t image/png $FILE
