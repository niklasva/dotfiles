#!/bin/bash
toggldata=$(curl -u b4568acba7a65732d4aa87940a81c603:api_token -X GET https://api.track.toggl.com/api/v8/time_entries/current 2>/dev/null)
secs=$(expr $(date +%s) + $(echo $toggldata | jq -r '.data.duration'))
desc=$(echo $toggldata | jq -r '.data.description')

if [ "$desc" != "null" ]; then
    printf " 鬒$desc "
    printf "%02d:%02d " $((secs/3600)) $((secs%3600/60))
fi
