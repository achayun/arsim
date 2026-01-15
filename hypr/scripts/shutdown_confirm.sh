#!/usr/bin/env bash

choice=$(printf "No\nYes" | wofi --dmenu --prompt "Shut down?" --width 200 --height 150)

if [ "$choice" == "Yes" ]; then
    systemctl poweroff
fi
