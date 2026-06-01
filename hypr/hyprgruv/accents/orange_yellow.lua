-- File: orange_yellow.lua
--
-- Orange/yellow Gruvbox flavor.
-- Warm, active, slightly vintage-terminal.
-- Good for coding, writing, terminal-heavy workspaces, focused UI.

local merge = require("hyprgruv/merge")
local base = require("hyprgruv/base")
local c = require("hyprgruv/gruvbox")

return merge(base, {
    name = "gruvbox-dark-orange-yellow",

    color = {
        accent = c.bright_orange,
        accent_alt = c.bright_yellow,

        positive = c.bright_green,
        info = c.bright_yellow,

        positive_muted = c.green,
        info_muted = c.yellow,

        border_focus = c.bright_orange,
        border_focus_alt = c.bright_yellow,

        selection_bg = c.dark_red_soft,
        selection_fg = c.light0,

        hover_bg = c.dark1,
        active_bg = c.dark2,
    },

    component = {
        window = {
            border = {
                active = {
                    colors = {
                        c.bright_orange,
                        c.bright_yellow,
                    },
                    angle = 45,
                },

                inactive = c.dark2,
            },

            shadow = {
                color = "#00000066",
            },
        },

        bar = {
            bg = c.dark0,
            fg = c.light1,

            module = {
                bg = c.dark1,
                fg = c.light1,
            },
        },

        workspace = {
            fg = c.light4,
            fg_empty = c.dark4,

            fg_visible = c.bright_yellow,
            fg_active = c.bright_orange,
            fg_special = c.yellow,
            fg_urgent = c.bright_red,

            bg = "transparent",
            bg_active = c.dark2,
            bg_visible = c.dark1,
            bg_special = c.dark1,
            bg_urgent = c.bright_red,

            indicator = c.bright_yellow,
        },

        tooltip = {
            bg = c.dark0,
            fg = c.light1,
            border = c.bright_yellow,
        },

        notification = {
            border = c.bright_orange,

            success = {
                bg = c.dark_green,
                fg = c.light0,
                border = c.bright_green,
            },

            info = {
                bg = c.dark1,
                fg = c.light0,
                border = c.bright_yellow,
            },
        },
    },
})
