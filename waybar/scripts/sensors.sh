#!/bin/bash

# Get sensors data in JSON format
DATA=$(sensors -j)

# Parse values using jq
# we use 'round' to keep the bar clean
TEMP1=$(echo "$DATA" | jq '."it8792-isa-0a60".temp1.temp1_input | round')
TEMP2=$(echo "$DATA" | jq '."it8792-isa-0a60".temp2.temp2_input | round')
POWER=$(echo "$DATA" | jq 'to_entries[] | select(.key | startswith("corsairpsu-hid-")) | .value."power total".power1_input | round')

# Output for Waybar
echo "{\"text\": \" $TEMP1° ⌂$TEMP2° |  ${POWER}W\", \"tooltip\": \"IT87 Temp1: $TEMP1°C\nIT87 Temp2: $TEMP2°C\nPSU Power: ${POWER}W\"}"

# Another way for waybar to get temperatures from source
# 
#     "temperature": {
#         "thermal-zone": 7,  // Check with: # cat /sys/class/hwmon/hwmon*/temp1_input
#         "hwmon-path": "/sys/class/hwmon/hwmon7/temp1_input",
#         "critical-threshold": 80,
#         "format-critical": "{temperatureC}°C ",
#         "format": "{temperatureC}°C "
#     },
