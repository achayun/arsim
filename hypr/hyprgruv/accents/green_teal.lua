-- Green/teal Gruvbox accent.
-- Inherits the base style and narrows the accent language toward
-- green + aqua/teal without changing the global design system.

local merge = require("hyprgruv/merge")
local base = require("hyprgruv/base")
local c = require("hyprgruv/gruvbox")

return merge(base, {
  name = "gruvbox-dark-green-teal",

  color = {
    accent = c.bright_green,
    accent_alt = c.bright_aqua,

    positive = c.bright_green,
    info = c.bright_aqua,

    positive_muted = c.green,
    info_muted = c.aqua,

    border_focus = c.bright_green,
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
            c.bright_green,
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
      fg_active = c.bright_green,
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
      border = c.bright_aqua,

      success = {
        bg = c.dark_green,
        fg = c.light0,
        border = c.bright_green,
      },

      info = {
        bg = c.dark_aqua,
        fg = c.light0,
        border = c.bright_aqua,
      },
    },
  },
})
