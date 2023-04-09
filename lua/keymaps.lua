--=====================================
-- Aliases --
local g = vim.g
local key = vim.api.nvim_set_keymap
local dopts = { noremap = true, silent = true }
--=====================================

--=====================================
-- Leader key
key("", "<Space>", "<Nop>", dopts)
g.mapleader = " "
g.maplocalleader = " "
--=====================================

--=====================================
-- ReMap default keys

--=====================================

--=====================================
-- Switch bufferline
key("n", "<S-h>", ":BufferLineCycleNext<CR>", dopts)
key("n", "<S-l>", ":BufferLineCyclePrev<CR>", dopts)
--=====================================

--=====================================
-- NvimTree
key("n", "<S-f>", ":NvimTreeFocus<CR>", dopts)
--=====================================
