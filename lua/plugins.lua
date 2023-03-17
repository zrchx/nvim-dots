-- Init --
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
  --==============================
  -- Packer --
  use 'wbthomason/packer.nvim'
  --==============================

  --==============================
  -- Utils --
  -- AutoPairs
  use 'windwp/nvim-autopairs'
  -- LSP
  use {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
  }
  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  -- CMP
  use 'hrsh7th/nvim-cmp'
  use {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip'
  }
  -- LuaSnip
  use 'L3MON4D3/LuaSnip'
  --==============================

  --==============================
  -- Visual And Icons --
  use 'nvim-tree/nvim-web-devicons'
  use 'folke/tokyonight.nvim'
  use 'NvChad/nvim-colorizer.lua'
  -- File explorer
  use 'nvim-tree/nvim-tree.lua'
  -- Bufferline
  use 'akinsho/bufferline.nvim'
  -- Status line
  use 'nvim-lualine/lualine.nvim'
  --==============================
end)
