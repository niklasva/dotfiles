#!/bin/sh

alias karabiner_cli="/Library/Application\ Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli"

next_profile=""
found_current=0

current_profile=$(karabiner_cli --show-current-profile-name)
profiles=$(karabiner_cli --list-profile-names)

IFS=$'\n'
for profile in $profiles; do
    if [ "$found_current" -eq 1 ]; then
        next_profile="$profile"
        break
    fi

    if [ "$profile" = "$current_profile" ]; then
        found_current=1
    fi
done

if [ -z "$next_profile" ]; then
    next_profile=$(echo "$profiles" | head -n 1)
fi

echo "Current Profile: $current_profile"
echo "Next Profile: $next_profile"

osascript -e "display notification \"Switching to profile: $next_profile\" with title \"Karabiner-Elements\""

karabiner_cli --select-profile "$next_profile"
