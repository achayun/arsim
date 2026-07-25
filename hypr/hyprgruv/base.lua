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
      gtk_pt = 11,
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

      surface = c.dark0_soft,
      surface_alt = c.dark1,
      surface_high = c.dark2,

      overlay = c.dark3,

      -- Text
      fg = c.light1,
      fg_strong = c.light0,
      fg_soft = c.light2,
      muted = c.light4,
      disabled = c.gray,

      -- One dominant UI accent
      accent = c.yellow,
      accent_alt = c.orange,

      -- Semantic accents: not for default chrome/widgets
      positive = c.bright_green,
      warning = c.bright_yellow,
      danger = c.bright_red,
      info = c.blue,

      positive_muted = c.green,
      warning_muted = c.yellow,
      danger_muted = c.red,
      info_muted = c.blue,

      -- Borders
      border = c.dark2,
      border_subtle = c.dark1,
      border_focus = c.dark4,
      border_focus_alt = c.dark3,

      selection_bg = c.dark2,
      selection_fg = c.light0,

      hover_bg = c.dark1,
      active_bg = c.dark2,
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
                  colors = { c.dark4, c.light4 },
                  angle = 45,
              },
              inactive = c.dark1,
          },

          radius = 0,

          opacity = {
              active = 1.0,
              inactive = 0.92,
          },

          shadow = {
              enabled = true,
              range = 14,
              render_power = 2,
              color = "#00000044",
          },

          blur = {
              enabled = true,
              size = 2,
              passes = 1,
          },
      },

      bar = {
          bg = c.dark0_hard,
          fg = c.light1,
          opacity = 0.96,

          module = {
              bg = c.dark0_soft,
              fg = c.light1,
              radius = 3,
              padding_x = 8,
              padding_y = 3,
              margin_x = 2,
              margin_y = 4,
          },
      },

      workspace = {
          fg = c.light4,
          fg_empty = c.dark4,
          fg_visible = c.light2,
          fg_active = c.light0,
          fg_urgent = c.bright_red,

          bg = "transparent",
          bg_active = c.dark2,
          bg_urgent = c.dark_red,

          radius = 3,
          padding_x = 7,
      },

      tooltip = {
          bg = c.dark0,
          fg = c.light1,
          border = c.dark3,
          radius = 0,
      },

      notification = {
          bg = c.dark1,
          fg = c.light1,
          border = c.dark3,

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
      browser = {
        incognito = c.purple,
        incognito_muted = c.dark3,
      }
  },

  icons = {
      theme = "Papirus-Dark"
  },
  cursor = {
      theme = "Bibata-Gruvbox-Modern", -- "Bibata-Modern-Classic",
      size = 24,

      -- Bibata Cursor plugin - will generate custom cursor and install
      bibata = {
          -- Bibata currently produces XCursors in this flow. Do not pretend this is a
          -- hyprcursor theme unless you add a real hyprcursor conversion step later.
          backend = "xcursor",

          -- Canonical Bibata sub-style. Flavors can override these only.
          shape = "modern",          -- "modern" | "original"
          orientation = "normal",    -- "normal" | "right"

          -- Build only what you use by default. Use {16, 20, 24, 32, 48} if you want
          -- a reusable package instead of a personal desktop theme.
          sizes = { 24 },

          colors = {
              -- Bibata color indexes:
              base = c.dark0_hard,  --   #00FF00 -> base cursor body
              outline = c.light2,   --   #0000FF -> outline
              watch = c.dark0,      --   #FF0000 -> watch / wait background
          },
      },
  },
  gtk = {
      gtk_theme = "Adwaita-dark",
      color_scheme = "prefer-dark",
      icon_theme = "Papirus-Dark"
  },
  fcitx5 = {
      theme = "Hypr-Gruvbox-Fcitx5",
      display_name = "Hypr Gruvbox Fcitx5",
      author = "Ami Chayun / Hyprland generator",
      version = "1.0",
      description = "Generated from the active Hyprland Gruvbox style",

      -- When true, write ~/.config/fcitx5/conf/classicui.conf Theme=<theme>.
      -- For pure generation only, keep false and call fcitx5.apply(style) manually.
      set_default = false,

      -- Fcitx5 Classic UI uses Pango-ish font strings such as "Sans 13".
      font = {
          input = 13,
          menu = 10,
      },

      spacing = 3,
      rounded = true,
      radius = 6,
      scale_with_dpi = true,

      -- Optional overrides. Omit these to use style.color roles.
      bg = c.dark0_soft,
      bg_alt = c.dark1,
      fg = c.light1,
      selected_fg = c.dark0_hard,
      accent = c.yellow,
      accent_alt = c.orange,
      input_bg = c.dark2,
      separator = c.dark0_hard,
  }
}
