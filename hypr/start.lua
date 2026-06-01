hl.on("hyprland.start", function ()
    hl.exec_cmd("waybar")
    hl.exec_cmd("fcitx5 -d --replace") -- Keyboard layouts and Japanese IME. see: https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprlauncher -d")
    -- -- Clipboard manager --
    -- Start the clipboard daemon (assuming hl.exec_once is used for initialization in your lua setup)
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)
