#!/bin/bash

HYPRCONF="$HOME/.config/hypr/hyprland.conf"
TIMEOUT=60

# TODO: Parse from config
SUPER=""
MOUSE="🖱"
get_binds() {
	grep -e '^\s*bindm\?d' "$HYPRCONF" | sed 's/^\s*bind[^ ]* = //g' | while read -r line; do
		MOD=$(echo "$line" | cut -d',' -f1 | xargs | sed "s/SUPER\s*/$SUPER /")
	 	KEY=$(echo "$line" | cut -d',' -f2 | xargs | sed "s/mouse:272/$MOUSE(L)/" | sed "s/mouse:273/$MOUSE(R)"/)
		DESC=$(echo "$line" | cut -d',' -f3 | xargs)
		CMD=$(echo "$line" | cut -d',' -f4 | xargs)
		APP=$(echo "$line" | cut -d',' -f5 | xargs)
		echo -e "$MOD+$KEY\n$DESC\n($CMD $APP)"
	done
}

(
	echo -e "ESC\nclose this cheatsheet\n"
	get_binds
	echo -e "\n\n     Window close in $TIMEOUT sec.";
) | yad \
	--fixed \
	--width=600 --height=700 --center \
	--title="Hyprland Keybindings" \
	--no-buttons \
	--list \
	--column="Key" --column="Description" --column="Command" \
	--timeout=$TIMEOUT --timeout-indicator=right \
	--separator="\n" \
	--search-column=2
