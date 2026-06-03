docker run --rm \
  -e SRC=/src \
  -e OUT=/out \
  -e NAME=Bibata-Hypr-GreenTeal \
  -e STYLE=modern \
  -e BASE='#1d2021' \
  -e OUTLINE='#525742' \
  -e WATCH='#282828' \
  -e SIZE=24 \
  -v "$HOME/.config/hypr/vendors/Bibata_Cursor:/src:ro" \
  -v "$HOME/.local/share/icons:/out" \
  hypr-bibata-builder
