-- ====================================
--          plugins config           --
-- ====================================
local options = {
    icons_enabled = true,
    theme = 'tokyonight',
    ignore_focus = { 'NvimTree' },
    globalstatus = true,
    sections = {
      lualine_a = {
        { 'mode', icons_enabled = true,  icon = { "" }, separator = { left = '', right = '' } }
      },
      lualine_b = {
        { 'filename',
          path = 1,
          icons_enabled = true,
          icon = { "" },
          file_status = true,
          newfile_status = false,
          symbols = {
            modified = ' ',
            readonly = ' ',
            unnamed = ' ﬘',
            newfile = ' ',
          },
          separator = { left = '', right = '' }
        },
      },
      lualine_c = {
        { 'branch', separator = { left = '', right = '' } },
        { 'diff', colored = true, symbols = { added = ' ', modified = '', removed = ' '}, separator = { left = '', right = '' }}
      },
      lualine_x = {
        { 'diagnostics', sources = { 'nvim_lsp' }, symbols = { error = ' ', warn = ' ', info = ' ', Hint = ' ' }, separator = { left = '', right = '' } }
      },
      lualine_y = {
        { function()
          local msg = 'NLS'
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
        icon = ' ',
        separator = { left = '', right = '' }
        },
        { 'filetype', colored = true , icon_only = true, separator = { left = '', right = '' } }
      },
      lualine_z = {
        {'progress', icons_enabled = true, icon = { "" }, separator = { left = '', right = '' }},
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
return options
