-- Aliases --
local key = vim.api.nvim_set_keymap
local dopts = { noremap = true, silent = true }

-- Switch bufferline
key("n", "<S-h>", ":BufferLineCycleNext", dopts)
key("n", "<S-l>", ":BufferLineCyclePrev", dopts)

-- Move selected line

-- Specs
