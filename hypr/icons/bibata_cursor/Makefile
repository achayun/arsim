# Cursor build integration for Bibata-generated XCursors.

SHELL := bash
.SHELLFLAGS := -euo pipefail -c
.DELETE_ON_ERROR:

export DOCKER_IMAGE_NAME ?= hypr-bibata-builder
CURSOR_DOCKERFILE ?= $(CURDIR)/Dockerfile
CURSOR_BUILD_SCRIPT ?= $(CURDIR/)build-bibata-cursor.sh
export BIBATA_SRC ?= $(CURDIR)/Bibata_Cursor
CURSOR_GEN_DIR ?= $(CURDIR)/generated/cursor
export CURSOR_OUT_DIR ?= $(HOME)/.local/share/icons
export CURSOR_DEFAULT_SIZE ?= 24

CURSOR_IMAGE_STAMP := .cache/$(DOCKER_IMAGE_NAME).podman_image


$(CURSOR_IMAGE_STAMP): $(CURSOR_DOCKERFILE) $(CURSOR_BUILD_SCRIPT) $(BIBATA_SRC)/.git
	@mkdir -p $(dir $@)
	podman build -f $(CURSOR_DOCKERFILE) -t $(DOCKER_IMAGE_NAME) .
	@touch $@

define RUN_BIBATA_CURSOR_BUILD
	@test -n "$(1)" || { echo "RENDER_JSON is required" >&2; exit 2; }
	@RENDER_JSON="$(1)" ./run.sh
endef

.PHONY: cursor-build
cursor-build: $(CURSOR_IMAGE_STAMP)
	$(call RUN_BIBATA_CURSOR_BUILD,$(RENDER_JSON))

$(CURSOR_OUT_DIR)/%/index.theme: $(CURSOR_GEN_DIR)/render-%.json $(CURSOR_IMAGE_STAMP)
	$(call RUN_BIBATA_CURSOR_BUILD,$<)

.PHONY: cursor-%
cursor-%: $(CURSOR_OUT_DIR)/%/index.theme
	@true

.PHONY: cursor-image-clean cursor-clean
cursor-image-clean:
	@rm -f $(CURSOR_IMAGE_STAMP)

cursor-clean:
	@rm -rf $(CURSOR_GEN_DIR)
