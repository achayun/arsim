#!/usr/bin/env bash
set -euo pipefail

: "${SRC:?SRC is required}"
: "${OUT:?OUT is required}"
: "${NAME:?NAME is required}"
: "${COMMENT:=?COMMENT is required}"
: "${RENDER_JSON:=?render.json file is required}"
: "${SIZE:=16 18 24 32}"

work=/tmp/bibata-work

rm -rf "$work"
mkdir -p "$work"

# Copy instead of building inside the mounted source.
# Keeps the git submodule clean.
rsync -a --delete "$SRC"/ "$work"/

cd "$work"

bitmap_dir="bitmaps/$NAME"

rm -rf "$bitmap_dir" "themes/$NAME"

# Phase 1: customize SVG files
if [ ! -f $RENDER_JSON ]; then
    echo "Could not find render.json file at $RENDER_JSON" >&2
    exit 1
fi
npx cbmp $RENDER_JSON

# Phase 2: render to bitmaps (PNG)
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
