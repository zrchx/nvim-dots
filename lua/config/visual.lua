-- Plugins Config --
-- Buffer Tabs
local buffer_opt = {
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
        text = "File Explorer",
        text_align = "center",

      },
    },
    hover = {
      enabled = true,
      delay = 25,
      reveal = {'close'}
    },
  }
}
-- Color theme
local tokyo_opt = {
  transparent = true,
  style = "night",
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = {},
    variables = {},
    sidebars = "normal",
    floats = "transparent",
  },
  lualine_bold = true,
}
-- Colorizer --
local colors_opt = {
  filetypes = { "*" },
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
  buftypes = {},
}
-- Configs Call --
require('tokyonight').setup(tokyo_opt)
require('bufferline').setup(buffer_opt)
require('colorizer').setup(colors_opt)
vim.defer_fn(function()
  require('colorizer').attach_to_buffer(0)
end, 0)
