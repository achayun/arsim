local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd)

-- Modifiers general assignment pattern:
-- SUPER - Navigation, Focus control, move focus to workspace etc
-- SUPER + SHIFT - window control (move to workspace, resize etc.)
-- SUPER + CTRL - Run programs, call commands etc
-- SUPER + ALT - System/session (shutdown etc)
-- Exceptions - most used apps are just on SUPER; special keys like PRINT don't take modifier

-- -- Language --
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd("fcitx5-remote -t"), { description = "(CTRL+space) change language" })

-- -- Quick launch Applications --
hl.bind(mainMod .. " + CTRL + T", hl.dsp.exec_cmd("kitty"), { description = "🖥️terminal" })
hl.bind(mainMod .. " + CTRL + G", hl.dsp.exec_cmd("steam -bigpicture"), { description = "🎮steam" })
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd("google-chrome-stable"), { description = "🖥️browser" })

-- -- Run programs, call commands --
hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd("keepassxc"), { description = "🔐passwords" })

-- Bind to Super+C/Super+V as universal copy/paste
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"), { description = "Open clipboard manager" })

-- Screenshot a region to clipboard
hl.bind("PRINT", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'), { description = "screenshot region" })

-- Classic Alt+F2 for launcher
hl.bind("ALT" .. " + F2", hl.dsp.exec_cmd('hyprlauncher'), { description = "Launcher" })

-- -- System commands --
hl.bind(mainMod .. " + Scroll_Lock", hl.dsp.exec_cmd("hyprlock"), { description = "Lock screen" })
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"), { description = "Lock screen" })
hl.bind(mainMod .. " + ALT + Escape", hl.dsp.exec_cmd("nwgbar"), { description = "🔌shutdown" })

-- -- Workspaces --
-- --- Workspace Navigation ---
local workspaces = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

for _, ws in ipairs(workspaces) do
    -- Switch to workspace
    hl.bind(mainMod .. " + " .. ws, hl.dsp.focus({ workspace = ws }), { description = "Switch to workspace " .. ws })

    -- Move active window to workspace
    hl.bind(mainMod .. " + SHIFT + " .. ws, hl.dsp.window.move({ workspace = ws }), { description = "Move window to workspace " .. ws })
end

-- Cycle through existing workspaces
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "e+1" }), { description = "Next workspace" })
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "e-1" }), { description = "Previous workspace" })

-- Window control
hl.bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen(0), { description = "fullscreen window (toggle)" })
hl.bind(mainMod .. " + ALT + Q", hl.dsp.window.close(), { description = "close active window" })

-- Close floating on whitelisted 'utlity' class windows with ESC.
hl.bind("Escape", function()
    local escape_closes = {
        ["org.pulseaudio.pavucontrol"] = true,
        ["pavucontrol"] = true,
    }
    local w = hl.get_active_window()
    if w ~= nil and w.floating and escape_closes[w.class] then
        hl.dispatch(hl.dsp.window.close({ window = w }))
    end
end, {
    non_consuming = true,
    description = "Close floating window",
})

-- Move windows with mainMod + SHIFT + [vim-style HJKL]
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }), { description = "move window left" })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }), { description = "move window right" })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }), { description = "move window up" })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }), { description = "move window down" })

-- Focus windows with mainMod + [vim-style HJKL]
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }), { description = "focus window left" })
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }), { description = "focus window right" })
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }), { description = "focus window up" })
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }), { description = "focus window down" })

-- Resize windows with arrows
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { description = "resize window left" })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 10,  y = 0, relative = true }), { description = "resize window right" })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,  y = -10, relative = true }), { description = "resize window up" })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,  y = 10, relative = true }), { description = "resize window down" })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true, description = "Move window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window" })

-- -- Notifications -- --
hl.bind(mainMod .. " + semicolon", hl.dsp.exec_cmd("makoctl dismiss"), { description = "Dismiss next notification" })
hl.bind(mainMod .. " + SHIFT + semicolon", hl.dsp.exec_cmd("makoctl dismiss -a"), { description = "Dismiss all notifications" })
hl.bind(mainMod .. " + CTRL + semicolon", hl.dsp.exec_cmd("makoctl restore"), { description = "Restore last notification" })
