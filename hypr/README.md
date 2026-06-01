# Hyprland Configuration

# Check for Cursor Theme

find ~/.icons ~/.local/share/icons /usr/share/icons \
  -maxdepth 2 -type f -name index.theme 2>/dev/null \
| grep -i bibata

And then:

grep '^Name=' /usr/share/icons/Bibata-Modern-Classic/index.theme
