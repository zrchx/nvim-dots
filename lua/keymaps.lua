--=====================================
-- Aliases --
local key = vim.api.nvim_set_keymap
local dopts = { noremap = true, silent = true }
--=====================================

--=====================================
-- Remap default keys

--=====================================

--=====================================
-- Switch bufferline
key("n", "<S-h>", ":BufferLineCycleNext<CR>", dopts)
key("n", "<S-l>", ":BufferLineCyclePrev<CR>", dopts)
--=====================================

--=====================================
-- Open Terminal
key("n", "<S-t>", ":terminal<CR>", dopts)
--=====================================

--=====================================
-- Savefiles
key("n", "<S-w>", ":w<CR>", dopts)
key("n", "<S-q>", ":q<CR>", dopts)
key("n", "<S-s>", ":wq<CR>", dopts)
--=====================================

--=====================================
-- NvimTree
key("n", "<S-f>", ":NvimTreeFocus<CR>", dopts)
--=====================================
