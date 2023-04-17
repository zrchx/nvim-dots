-- ====================================
--          Various Configs          --
local V = {}
-- Git Signs
V.gitsigns = {
  signs = {
    add = { text = ' ' },
    change = { text = ' ' },
    delete = { text = ' ' },
    topdelete = { text = ' ' },
    changedelete = { text = ' ' },
    untracked = { text = ' ' },
  },
  signcolumn = false,
  numhl = false,
  linehl = false,
  word_diff = false,
}

-- Lazy nvim
V.lazy_nvim = {
  defaults = { lazy = true },
  ui = {
    icons = {
      ft = "",
      lazy = "鈴 ",
      loaded = "",
      not_loaded = "",
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}
-- Treesitter
V.treesitter = {
    ensure_installed = { "cpp", "lua", "bash" },
    highlight = { enable = true, use_languagetree = true },
    indent = { enable = true, }
}
-- Auto-Pairs
V.autopairs = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt" },
}
-- Mason
V.mason = {
  ensure_installed = { "lua-language-server", "clandg" },
  PATH = "skip",
  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ﮊ",
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },
  max_concurrent_installers = 2,
}
-- LuaSnip
V.luasnip = function ()
  require("luasnip").config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI"
  })
  -- VS Format
  require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.luasnippets_path or "" }
  require("luasnip.loaders.from_vscode").lazy_load()
  -- Snipmate Format
  require("luasnip.loaders.from_snipmate").load()
  require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }
  -- Lua Format
  require("luasnip.loaders.from_lua").load()
  require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }
  -- Insert mode
  vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
      if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require("luasnip").session.jump_active
      then
        require("luasnip").unlink_current()
      end
	  end,
  })
end
-- Blankline
V.blankline = {
  indentLine_enabled = 1,
  filetype_exclude = {
    "help",
    "terminal",
    "lazy",
    "lspinfo",
    "mason",
  },
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
  show_current_context = true,
  show_current_context_start = true,
}
return V
-- ====================================
