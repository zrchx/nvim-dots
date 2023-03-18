-- Lua line --
local config = {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    ignore_focus = { 'NvimTree'},
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      { 'mode', icons_enabled = true,  icon = { "" }, separator = {left = '', right = ''} }
    },
    lualine_b = {
      { 'filename', path = 1, icons_enabled = true, icon = { "" }, file_status = true, newfile_status = false, symbols = { modified = ' ', readonly = ' ', unnamed = ' ﬘', newfile = ' ', } },
    },
    lualine_c = {
      { 'branch' },
      { 'diff', colored = true, symbols = { added = ' ', modified = '', removed = ' '}}
    },
    lualine_x = {
      { 'diagnostics', sources = { 'nvim_lsp' }, symbols = { error = ' ', warn = ' ', info = ' ', Hint = ' ' } }
     },
    lualine_y = {
      { function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
        return msg
      end,
      icon = '  ~',
      },
      { 'filetype', colored = true , icon_only = true}
    },
    lualine_z = {
      {'progress', icons_enabled = true, icon = { "" }},
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
}
-- Configs Call --
require('lualine').setup(config)
