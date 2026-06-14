

DOCKER_IMAGE_NAME = hypr-bibata-builder
LOCAL_SHARE_ICONS = $(HOME)/.local/share/icons/

image_md5:
	podman build -t $(DOCKER_IMAGE_NAME) .

generated/%.json

# Generate a JSON and jq all the parameters in this line
$(LOCAL_SHARE_ICONS)/%/index.theme: generated/%.json | image_md5
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
	  -v "$(dir $@)/icons:/out" \
	  $(DOCKER_IMAGE_NAME)
