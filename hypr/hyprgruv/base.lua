-- File: style/base.lua
--
-- Base style layer.
-- Pure style data: maps raw Gruvbox tokens to semantic UI roles.
-- No Hyprland calls. No Waybar CSS. No file output.

local c = require("hyprgruv/gruvbox")
local f = require("hyprgruv/fonts")

return {
  name = "gruvbox-dark-base",

  font = {
    ui = f.inter,
    mono = f.nerd,

    size = {
      bar = 15,
      ui = 14,
      mono = 13,
    },

    weight = {
      normal = 400,
      medium = 500,
      bold = 700,
    },
  },

  color = {
    -- Core surfaces
    bg = c.dark0,
    bg_hard = c.dark0_hard,
    bg_soft = c.dark0_soft,

    surface = c.dark1,
    surface_alt = c.dark2,
    surface_high = c.dark3,

    overlay = c.dark4,

    -- Text
    fg = c.light1,
    fg_strong = c.light0,
    fg_soft = c.light2,
    muted = c.light4,
    disabled = c.gray,

    -- Semantic accents
    accent = c.bright_blue,
    accent_alt = c.bright_aqua,

    positive = c.bright_green,
    warning = c.bright_yellow,
    danger = c.bright_red,
    info = c.bright_blue,

    -- Low-intensity semantic accents
    positive_muted = c.green,
    warning_muted = c.yellow,
    danger_muted = c.red,
    info_muted = c.blue,

    -- Borders
    border = c.dark2,
    border_subtle = c.dark1,
    border_focus = c.light4,
    border_focus_alt = c.dark3,

    -- Selection / fills
    selection_bg = c.dark2,
    selection_fg = c.light0,

    hover_bg = c.dark1,
    active_bg = c.dark2,

    -- Terminal-ish ANSI role mapping, useful later
    ansi = {
      black = c.dark0,
      red = c.bright_red,
      green = c.bright_green,
      yellow = c.bright_yellow,
      blue = c.bright_blue,
      magenta = c.bright_purple,
      cyan = c.bright_aqua,
      white = c.light1,

      bright_black = c.gray,
      bright_red = c.bright_red,
      bright_green = c.bright_green,
      bright_yellow = c.bright_yellow,
      bright_blue = c.bright_blue,
      bright_magenta = c.bright_purple,
      bright_cyan = c.bright_aqua,
      bright_white = c.light0,
    },
  },

  metric = {
    gap = {
      inner = 1,
      outer = 0,
    },

    border = {
      width = 1,
      radius = 0,
    },

    padding = {
      x = 8,
      y = 3,
    },

    margin = {
      x = 3,
      y = 4,
    },
  },

  opacity = {
    active = 1.0,
    inactive = 0.92,
    floating = 0.96,
    bar = 0.96,
    tooltip = 0.95,
  },

  component = {
    window = {
      border = {
        width = 1,
        active = {
          colors = { c.light3, c.light4 },
          angle = 45,
        },
        inactive = c.dark2,
      },

      radius = 0,

      opacity = {
        active = 1.0,
        inactive = 0.90,
      },

      shadow = {
        enabled = true,
        range = 18,
        render_power = 2,
        color = "#00000055",
      },

      blur = {
        enabled = true,
        size = 3,
        passes = 1,
      },
    },

    bar = {
      bg = c.dark0,
      fg = c.light1,
      opacity = 0.96,

      module = {
        bg = c.dark1,
        fg = c.light1,
        radius = 4,
        padding_x = 8,
        padding_y = 3,
        margin_x = 3,
        margin_y = 4,
      },
    },

    workspace = {
      fg = c.light4,
      fg_empty = c.dark4,
      fg_visible = c.bright_aqua,
      fg_active = c.bright_blue,
      fg_urgent = c.bright_red,

      bg = "transparent",
      bg_active = c.dark2,
      bg_urgent = c.bright_red,

      radius = 0,
      padding_x = 6,
    },

    tooltip = {
      bg = c.dark0,
      fg = c.light1,
      border = c.bright_blue,
      radius = 0,
    },

    notification = {
      bg = c.dark1,
      fg = c.light1,
      border = c.bright_blue,

      critical = {
        bg = c.dark_red,
        fg = c.light0,
        border = c.bright_red,
      },

      success = {
        bg = c.dark_green,
        fg = c.light0,
        border = c.bright_green,
      },
    },
  },

  icons = {
      theme = "Papirus-Dark"
  },
  cursor = {
      theme = "Bibata-Modern-Classic",
      size = 24
  },
  gtk = {
      gtk_theme = "Adwaita-dark",
      color_scheme = "prefer-dark",
      icon_theme = "Papirus-Dark"
  }
}
