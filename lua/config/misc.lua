-- Plugins Config --
-- Treesitter
local treesitter_opt = {
  ensure_installed = { "c", "cpp", "lua", "bash" },
  highlight = { enable = true, use_languagetree = true },
  indent = { enable = true, }
}
-- Auto-Pairs
local autopairs_opt = {
  fast_wrap = {},
  disable_filetype = { "TelescopePrompt" },
}
-- Configs calls --
require('nvim-treesitter.configs').setup(treesitter_opt)
require('nvim-autopairs').setup(autopairs_opt)
