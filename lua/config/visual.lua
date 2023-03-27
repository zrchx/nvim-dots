-- Plugins Config --
local v = {}
-- Color theme
v.tokyonight = {
  style = "night",
  light_style = "moon",
  transparent = true,
  terminal_colors = true,
  styles = {
    sidebars = "dark",
    floats = "dark",
  },
  hide_inactive_statusline = true,
  lualine_bold = true,
}
-- Buffer Tabs
v.bufferline = {
  options = {
    always_show_bufferline = true,
    separator_style = {"▎", "" },
    indicator = {
      icon = '▎',
      style = 'icon'
    },
    offsets = {
      {
        filetype = "NvimTree",
        text = " File Explorer",
        text_align = "center",
      },
    },
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },
  }
}
-- Colorizer --
v.colorizer = {
  filetypes = { "*" },
  buftypes = {},
  user_default_options = {
    RGB = true,
    RRGGBB = true,
    names = false,
    RRGGBBAA = true,
    AARRGGBB = false,
    mode = "background",
    virtualtext = "■",
    always_update = false
  },
}
-- Line mark
v.specs = {
  show_jumps  = true,
  min_jump = 30,
  popup = {
    delay_ms = 0, -- delay before popup displays
    inc_ms = 10, -- time increments used for fade/resize effects 
    blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
    width = 10,
    winhl = "PMenu",
    fader = require('specs').pulse_fader,
    resizer = require('specs').slide_resizer
  },
  ignore_filetypes = { },
  ignore_buftypes = { },
}
return v
