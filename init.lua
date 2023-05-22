-- ====================================
-- Aliases --
local o = vim.opt
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
require"plugins"
require"keymaps"
-- ====================================

-- ====================================
--               Configs             --
-- Search --
o.ignorecase = true
o.smartcase = true
-- Cmd Line --
o.showmode = false
o.history = 100
o.pumheight = 10
o.completeopt = {"menuone", "noselect"}
-- Files --
o.fileencoding = "utf-8"
o.undofile = true
-- Mouse --
o.mouse = "a"
o.mousemoveevent = true
-- Tabs --
o.expandtab = true
o.smartindent = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
-- Visual --
o.fillchars = { eob = " " }
o.cursorline = true
o.termguicolors = true
-- Split --
o.splitright = true
o.splitbelow = true
-- Numbers --
o.ruler = false
o.number = true
o.numberwidth = 2
-- Misc --
g.transparency = 0.9
g.mapleader = " "
vim.cmd[[colorscheme tokyonight]]
o.clipboard = "unnamedplus"
o.timeoutlen = 400
o.updatetime = 250
vim.o.showmode = false
-- ====================================

-- ====================================
-- Disable some things
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
    g["loaded_" .. provider .. "_provider"] = 0
end
-- LSP path to binaries
vim.env.PATH = vim.env.PATH .. ":" .. fn.stdpath "data" .. "/mason/bin"
-- ====================================
