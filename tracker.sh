#!/bin/bash

# Time tracking script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export $(grep -v '^#' "$SCRIPT_DIR/.env" | xargs)


# remove the first part of the file
cat $SCRIPT_DIR/sync-data.json | sed 's/pf_2__//' | jq '.' > $SCRIPT_DIR/formated_data.json
today="${1:-$(date +"%Y-%m-%d")}"

mapfile -t tasks < <(jq -r ".state.task.entities[] | [.title, .timeSpentOnDay[\"$today\"]] | @csv" $SCRIPT_DIR/formated_data.json)
for task in "${tasks[@]}"; do
    title=$(echo $task | cut -d ',' -f1 | tr -d '"')
    ms=$(echo $task | cut -d ',' -f2 | tr -d '"')

    if [[ $ms == "" ]]; then
        ms=0
    fi
    second=$((60 * 60 * 60))
    hours=$(echo "scale=2; $ms / 3600000" | bc -l)

    encoded_title=$(echo "$title" | sed 's/ /%20/g')
    week_start_date=$(date -d "last saturday" +%F)
    if [[ $# != 0 ]]; then
        day_of_the_week=$(date -d "yesterday" +%A)
    else
        day_of_the_week=$(date +%A)
    fi
    curl -L "$URL?date=$today&task=$encoded_title&hours=$hours&week_start=$week_start_date&day_of_the_week=$day_of_the_week" \
    && echo "$(date "+%Y-%m-%d %H:%M")" > "$SCRIPT_DIR/last_succes.log"
done

