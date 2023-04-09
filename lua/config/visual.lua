-- ====================================
--          plugins config           --
-- ====================================
local v = {}
-- Color theme
v.tokyonight = {
  style = "night",
  light_style = "moon",
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
return v
