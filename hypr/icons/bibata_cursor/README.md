# Hyprland Lua Bibata cursor generator

The flow of usage from cursor.lua:
1. Gets as an input <theme>/style.lua and generates a render-%.json.
2. Calls the Makefile to compile and install the cursor theme.
3. Once the theme is installed, call gsettings, hyprctl and export environment to properly set it.

The Makefile uses a Dockerfile (podman) image to generate the cursor theme (Bibata uses npx and other dependencies)

The generation script performs three steps:
a. Customize the SVG icons
b. Render to bitmaps
c. Convert to XCursor and install to destination folder
