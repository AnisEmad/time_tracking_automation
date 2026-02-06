#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


last_date=$(cat "$SCRIPT_DIR/last_succes.log")
yesterday=$(date -d "yesterday" +"%Y-%m-%d")

last=${last_date:0:10}
time=${last_date:10}
if [[ $last == "$(date +"%Y-%m-%d")" ]]; then
    exit 0
elif [[ "$last" != "$yesterday" ]]; then
    echo "script running"
    sleep 5m
    "$SCRIPT_DIR/tracker.sh" $yesterday
fi
