-- Aliases --
local key = vim.api.nvim_set_keymap
local dopts = { noremap = true, silent = true }

-- Switch bufferline
key("n", "<S-h>", ":BufferLineCycleNext", dopts)
key("n", "<S-l>", ":BufferLineCyclePrev", dopts)

-- Move selected line
key("x", "K", ":move '<-2<CR>gv-gv", dopts)
key("x", "J", ":move '>+1<CR>gv-gv", dopts)

-- Specs
key('n', '<C-b>', ':lua require("specs").show_specs()<CR>', dopts)
