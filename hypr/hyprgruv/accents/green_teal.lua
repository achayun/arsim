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
    cursor = {
        theme = "Bibata-Gruvbox-Green-Teal-Modern", -- "Bibata-Modern-Classic",
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
                outline = c.bright_green,   --   #0000FF -> outline
                watch = c.dark0,      --   #FF0000 -> watch / wait background
            },
        },
    },
})
