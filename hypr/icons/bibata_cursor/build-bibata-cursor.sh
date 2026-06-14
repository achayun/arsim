#!/usr/bin/env bash
set -euo pipefail

: "${OUT:?OUT is required}"
: "${COMMENT:?COMMENT is required}"
: "${RENDER_JSON:?RENDER_JSON file is required}"
: "${SIZE:=16 18 24 32}"

work=/tmp/bibata-work

rm -rf "$work"
mkdir -p "$work"

# Copy instead of building inside the mounted source.
# Keeps the git submodule clean.
rsync -a --delete /src/ "$work"/
cd "$work"

# Phase 1: customize SVG files
if [ ! -f $RENDER_JSON ]; then
    echo "Could not find render.json file at $RENDER_JSON" >&2
    exit 1
fi

# Support one theme exactly
NAME=$(jq -r 'keys_unsorted | if length == 1 then .[0] else error("render json must contain exactly one cursor theme") end' "$RENDER_JSON")

bitmap_dir="bitmaps/$NAME"

rm -rf "$bitmap_dir" "themes/$NAME"

npx --no-install cbmp $RENDER_JSON

# Phase 2: render to bitmaps (PNG)
svg_dir=$(jq -r 'to_entries[0].value.dir' "$RENDER_JSON")
if [[ "$svg_dir" == *-right ]]; then
    build_toml="Bibata_Cursor/configs/right/x.build.toml"
else
    build_toml="Bibata_Cursor/configs/normal/x.build.toml"
fi

if [ ! -f $build_toml ]; then
    echo "Could not find Bibata ctgen build config at $build_toml" >&2
    exit 1
fi

ctgen "$build_toml" \
    -o "themes" \
    -s $SIZE \
    -p x11 \
    -d "$bitmap_dir" \
    -n "$NAME" \
    -c "$COMMENT - Generated from Hyprland theme"

if [ ! -d "themes/$NAME" ]; then
    echo "Expected generated theme not found: themes/$NAME" >&2
    exit 1
fi

# Phase 3: install
mkdir -p "$OUT"
rm -rf "$OUT/$NAME"
cp -a "themes/$NAME" "$OUT/$NAME"

echo "Installed cursor theme:"
echo "  $OUT/$NAME"
