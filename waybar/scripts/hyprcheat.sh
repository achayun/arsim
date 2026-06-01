#!/bin/bash

TIMEOUT=60

SUPER=""
MOUSE="🖱"
get_binds() {
    hyprctl -j binds | jq -r '.[] | select(.description != "") | [
        # 1. Reconstruct modifiers string from modmask by checking bit flags mathematically
        ((if (.modmask % 128 / 64 | floor) == 1 then "'"$SUPER"'" else "" end) +
         (if (.modmask % 8 / 4 | floor) == 1 then " CTRL" else "" end) +
         (if (.modmask % 16 / 8 | floor) == 1 then " ALT" else "" end) +
         (if (.modmask % 2 / 1 | floor) == 1 then " SHIFT" else "" end)
         | sub("^ "; "") | gsub(" "; " + ")),

        # 2. Extract and format Key/Mouse information
        (if .key == "mouse:272" then "'"$MOUSE"'(L)"
         elif .key == "mouse:273" then "'"$MOUSE"'(R)"
         else .key end),

        # 3. Pull description and final command strings
        .description,
        .dispatcher,
        .arg
        ] | @tsv' | while IFS=$'\t' read -r mods key desc disp arg; do

        # Format MOD + KEY cleanly depending on whether a modifier exists
        if [ -n "$mods" ]; then
            MOD_KEY="$mods + $key"
        else
            MOD_KEY="$key"
        fi

        # Print a columnar output where \n is the column separator
        echo -e "${MOD_KEY}\n${desc}"
    done
}

(
	echo -e "ESC\nclose this cheatsheet"
	get_binds
	echo -e "\n     Window close in $TIMEOUT sec.";
) | yad \
	--fixed \
	--width=600 --height=700 --center \
	--title="Hyprland Keybindings" \
	--no-buttons \
	--list \
	--column="Key" --column="Description" \
	--timeout=$TIMEOUT --timeout-indicator=right \
	--separator="\n" \
	--search-column=2
