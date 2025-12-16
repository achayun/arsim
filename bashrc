# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Not interactive, bye
[[ $- != *i* ]] && return

# All SSH connections should be inside tmux
if [ -n "$PS1" ] && [ -z "$TMUX" ] && [ -n $SSH_CONNECTION ]; then
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
