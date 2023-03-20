-- ====================================
-- Aliases --
local o = vim.opt
local c = vim.cmd
local g = vim.g
local fn = vim.fn
-- ====================================

-- ====================================
-- Bootstrap --
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
o.rtp:prepend(lazypath)
-- Configs --
require'plugins'
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
-- Color theme
c.colorscheme "tokyonight-night"

o.splitbelow = true
o.splitright = false

o.laststatus = 3

-- Numbers
o.ruler = false
o.number = true
o.numberwidth = 2

-- Disable some things
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  g["loaded_" .. provider .. "_provider"] = 0
end

-- LSP path to binaries
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.env.PATH .. (is_windows and ";" or ":") .. fn.stdpath "data" .. "/mason/bin"
-- ====================================
