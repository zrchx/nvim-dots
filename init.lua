-- ====================================
-- Aliases --
local o = vim.opt
local c = vim.cmd
local g = vim.g
-- ====================================

-- ====================================
-- Archives --
-- Packer
require'plugins'
-- Some plugins Configs
require'config.misc'
-- CMP config
require'config.cmp'
-- Visual config
require'config.visual'
-- LSP config
require'config.lspconf'
-- Files and bar config
require'config.nvimtree'
-- Statusbar config
require'config.statusbar'
-- ====================================

-- ====================================
-- Configs --
o.ignorecase = true
o.smartcase = true

o.whichwrap:append "<>[]hl"

o.timeoutlen = 400
o.updatetime = 250

-- Mouse
o.mouse = "a"
o.mousemoveevent = true

-- Tabs
o.fillchars = { eob = " " }

o.expandtab = true
o.smartindent = true

o.shiftwidth = 2
o.softtabstop = 2
o.tabstop = 2

-- Visual
o.cursorline = true
o.showmode = false
o.termguicolors = true
c.colorscheme "tokyonight-night"

o.splitbelow = true
o.splitright = false

o.laststatus = 3

-- Numbers
o.ruler = true
o.number = true
o.numberwidth = 2

-- Disable plugins
local default_plugins = {
  "2html_plugin",
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
}

for _, plugin in pairs(default_plugins) do
  g["loaded_" .. plugin] = 1
end

-- LSP path to binaries
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. vim.fn.stdpath "data" .. "/mason/bin"
-- ====================================
