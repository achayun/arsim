#!/usr/bin/env bash
set -euo pipefail

: "${SRC:?SRC is required}"
: "${OUT:?OUT is required}"
: "${NAME:?NAME is required}"
: "${STYLE:=modern}"
: "${BASE:?BASE is required}"
: "${OUTLINE:?OUTLINE is required}"
: "${WATCH:=$BASE}"
: "${SIZE:=24}"

work=/tmp/bibata-work

rm -rf "$work"
mkdir -p "$work"

# Copy instead of building inside the mounted source.
# Keeps the git submodule clean.
rsync -a --delete "$SRC"/ "$work"/

cd "$work"

# Install repo-local node dependencies if package.json exists.
# This keeps us aligned with the repo instead of assuming global cbmp details.
if [ -f package-lock.json ]; then
    npm ci
elif [ -f package.json ]; then
    npm install
fi

case "$STYLE" in
    modern)
        svg_dir="svg/modern"
        ;;
    original)
        svg_dir="svg/original"
        ;;
    *)
        echo "Unknown Bibata style: $STYLE" >&2
        exit 1
        ;;
esac

bitmap_dir="bitmaps/$NAME"

rm -rf "$bitmap_dir" "themes/$NAME"

npx cbmp \
    -d "$svg_dir" \
    -o "$bitmap_dir" \
    -bc "$BASE" \
    -oc "$OUTLINE" \
    -wc "$WATCH"

if [ -f configs/normal/x.build.toml ]; then
    build_toml="configs/normal/x.build.toml"
elif [ -f build.toml ]; then
    build_toml="build.toml"
else
    echo "Could not find Bibata ctgen build config" >&2
    exit 1
fi

ctgen "$build_toml" \
    -s "$SIZE" \
    -p x11 \
    -d "$bitmap_dir" \
    -n "$NAME" \
    -c "$NAME generated from Hyprland theme"

if [ ! -d "themes/$NAME" ]; then
    echo "Expected generated theme not found: themes/$NAME" >&2
    exit 1
fi

mkdir -p "$OUT"
rm -rf "$OUT/$NAME"
cp -a "themes/$NAME" "$OUT/$NAME"

echo "Installed cursor theme:"
echo "  $OUT/$NAME"
