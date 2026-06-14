DOCKER_IMAGE_NAME=hypr-bibata-builder

podman build -t $DOCKER_IMAGE_NAME .
podman run --rm \
  -e SRC=/src \
  -e OUT=/out \
  -e NAME='Bibata-Gruvbox' \
  -e STYLE=modern \
  -e ORIENT=left \
  -e BASE='#282828' \
  -e OUTLINE='#EBDBB2' \
  -e WATCH='#000000' \
  -e SIZE=24 \
  -e NAME='Bibata-Amber-Modern' \
  -e COMMENT='Glowing Amber Bibata cursors.' \
  -v "$HOME/.local/share/icons:/out" \
  $DOCKER_IMAGE_NAME
