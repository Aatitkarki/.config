#!/bin/zsh

while true; do

    # Get the current battery percentage
    battery_percentage=$(pmset -g batt | grep -Eo "\d+%" | awk -F '%' '{print $1}')

    # Check if the laptop is charging
    charging_status=$(pmset -g batt | grep "charging")

    if [ -n "$charging_status" ]; then
        # Battery is charging
        if [ "$battery_percentage" -gt 80 ]; then
            osascript -e 'display notification "Battery is charged. You can unplug your charger." with title "Battery Alert"'
        fi
    else
        # Battery is not charging
        if [ "$battery_percentage" -lt 20 ]; then
            osascript -e 'display notification "Battery is low. Please plug in your charger." with title "Battery Alert"'
        fi
    fi


    # Sleep for a while before checking again (adjust as needed)
    sleep 600
done

