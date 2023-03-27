local u = {}
-- Nvim Tree --
u.nvimtree = {
  filters = {
    dotfiles = false,
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  update_focused_file = {
    enable = true,
  },
  view = {
    adaptive_size = true,
    side = "left",
    width = 25,
    hide_root_folder = true,
  },
  git = {
    enable = false,
    ignore = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    highlight_git = false,
    highlight_opened_files = "none",

    indent_markers = {
      enable = false,
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = " ",
          staged = " ",
          unmerged = "",
          renamed = " ",
          untracked = "社",
          deleted = " ",
          ignored = "",
        },
      },
    },
  },
}
-- Lualine --
u.lualine = {
  options = {
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
}
u.snap =function ()
  local snap = require'snap'
  snap.config.file {
    reverse = true,
    prompt = " Files",
    suffix = "",
    consumer = "fzf"
  }
  snap.run {
    producer = snap.get'consumer.fzf'(snap.get'producer.ripgrep.file'),
    select = snap.get'select.file'.select,
    multiselect = snap.get'select.file'.multiselect,
    views = {snap.get'preview.file'}
  }
end
return u
