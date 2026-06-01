-- File: blue_aqua.lua
--
-- Blue/aqua Gruvbox flavor.
-- Cooler, calmer, more technical.
-- Good for monitoring, system work, media/control surfaces, or "clean dashboard" mode.

local merge = require("hyprgruv/merge")
local base = require("hyprgruv/base")
local c = require("hyprgruv/gruvbox")

return merge(base, {
    name = "gruvbox-dark-blue-aqua",

    color = {
        accent = c.bright_blue,
        accent_alt = c.bright_aqua,

        positive = c.bright_aqua,
        info = c.bright_blue,

        positive_muted = c.aqua,
        info_muted = c.blue,

        border_focus = c.bright_blue,
        border_focus_alt = c.bright_aqua,

        selection_bg = c.dark_aqua,
        selection_fg = c.light0,

        hover_bg = c.dark_aqua_hard,
        active_bg = c.dark_aqua,
    },

    component = {
        window = {
            border = {
                active = {
                    colors = {
                        c.bright_blue,
                        c.bright_aqua,
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

            fg_visible = c.bright_aqua,
            fg_active = c.bright_blue,
            fg_special = c.aqua,
            fg_urgent = c.bright_red,

            bg = "transparent",
            bg_active = c.dark_aqua,
            bg_visible = c.dark1,
            bg_special = c.dark_aqua_hard,
            bg_urgent = c.bright_red,

            indicator = c.bright_aqua,
        },

        tooltip = {
            bg = c.dark0,
            fg = c.light1,
            border = c.bright_aqua,
        },

        notification = {
            border = c.bright_blue,

            success = {
                bg = c.dark_aqua,
                fg = c.light0,
                border = c.bright_aqua,
            },

            info = {
                bg = c.dark_aqua,
                fg = c.light0,
                border = c.bright_blue,
            },
        },
    },
})
