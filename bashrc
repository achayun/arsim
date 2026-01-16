# Setup interactive SSH sessions to automatically run inside tmux


# Not interactive ssh session, bye
[[ $- != *i* ]] || [ -z "$SSH_CLIENT" ] && return

# All SSH connections should be inside tmux
if [ -n "$PS1" ] && [ -z "$TMUX" ] && [ -n "$SSH_CONNECTION" ]; then
	export SESSION_NAME="${TERM_PROGRAM:-interactive}"
	tmux attach -t $SESSION_NAME || tmux new -s $SESSION_NAME
fi

if [ -z "$TMUX" ]; then
cat <<'EOF'
┌──────────────────────────────────────────────┐
│                                              │
│   Not running inside TMUX                    │
│                                              │
│   Development environment setup skipped.     │
│                                              │
│   Proceed deliberately.                      │
│                                              │
└──────────────────────────────────────────────┘
EOF
return
fi

### From here on, setup your development environment ###

where_am_i() {
        # Location banner (cache to avoid being That Guy)
        IPINFO_CACHE="$HOME/.cache/ipinfo"
        CACHE_TTL=86400  # 24h, because continents don't teleport

        mkdir -p "$(dirname "$IPINFO_CACHE")"

        mtime=$(date -r "$IPINFO_CACHE" +%s 2>/dev/null)
        if [ ! -f "$IPINFO_CACHE" ] || [ $mtime -gt $CACHE_TTL ]; then
                curl -s --max-time 2 "https://ipinfo.io/$(curl -s --max-time 2 ifconfig.me)" \
                        > "$IPINFO_CACHE" 2>/dev/null
        fi

        CITY=$(jq -r '.city // "Unknown"' "$IPINFO_CACHE")
        REGION=$(jq -r '.region // ""' "$IPINFO_CACHE")
        COUNTRY=$(jq -r '.country // "??"' "$IPINFO_CACHE")
        ORG=$(jq -r '.org // "Unidentified Network"' "$IPINFO_CACHE")
        TZ=$(timedatectl show -p Timezone --value 2>/dev/null)

        printf "📍%s, %s %s · %s" "$CITY" "$REGION" "$COUNTRY" "$ORG"
}

cat <<EOF

┌──────────────────────────────────────────────┐
│                                              │
│  $(printf '%.40s' "$(where_am_i)")       │
│                                              │
│   Ready to setup project environment.        │
│   Use the following commands                 │
│                                              │
│       proj1 - setup PROJ                     │
│                                              │
└──────────────────────────────────────────────┘

EOF
