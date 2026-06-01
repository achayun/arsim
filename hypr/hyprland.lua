-- Default programs
local terminal      = "kitty"
local fileManager   = "thunar"
local menu          = "hyprlauncher"
local browser       = "google-chrome-stable"
local shell         = os.getenv("SHELL") -- or set to bashrc/zshrc etc.

-- General configuration
require("monitors")
require("start")
require("bind")
require("input")
require("window")

-- Specific application classes behavior
require("tools")
require("steam")

-- Look and feel
local theme = require("hyprgruv/accents/orange_yellow")
local style = require("style")
local waybar = require("waybar")
local nwgbar = require("nwgbar")
local hyprtoolkit = require("hyprtoolkit")
local gtk = require("gtk")

style(theme)
waybar.write(theme)
nwgbar.write(theme)
hyprtoolkit.write(theme)
require("cursor").apply(theme)
gtk.write(theme)
require("shell").write(theme, shell)
require("hyprlock").write(theme, {
    wallpaper = os.getenv("HOME") .. "/dev/arsim/hypr/hyprgruv/wallpapers/peter-thomas-qqc8LV95_0w-unsplash.jpg",
})

require("mako").write(theme)
local function starts_with(s, prefix)
    return tostring(s):sub(1, #prefix) == prefix
end

if starts_with(browser, "google-chrome") then
    local chrome_wallpaper = {
        path = os.getenv("HOME") .. "/.config/hypr/hyprgruv/wallpapers/footer_lodyas.png",
        repeat_policy = "repeat", -- "no-repeat", "repeat", "repeat-x", "repeat-y"
        -- alignment = "bottom",        -- "center", "bottom", "top", etc.
        logo_alternate = 1,
    }
    local chrome_theme_dir = require("google-chrome").write(theme, chrome_wallpaper)

    print("Chrome theme generated at: " .. chrome_theme_dir)
    print("Load unpacked from chrome://extensions")
end

