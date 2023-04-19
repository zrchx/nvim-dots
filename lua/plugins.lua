-- Lazy load
local lazy_load = function(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = vim.fn.expand "%"
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""
      if condition then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)
        if plugin ~= "nvim-treesitter" then
          vim.schedule(function()
            require("lazy").load { plugins = plugin }
            if plugin == "nvim-lspconfig" then
              vim.cmd "silent! do FileType"
            end
          end, 0)
        else
          require("lazy").load { plugins = plugin }
        end
      end
    end,
  })
end
-- List of plugins
local plugins = {
  -- =======================================
  -- Utils --
  -- =======================================

  -- =======================================
  -- LSP
  { 'neovim/nvim-lspconfig',
    init = lazy_load "nvim-lspconfig",
    config = function ()
      require'config.lspconf'
    end,
  },
  -- Mason
  { 'williamboman/mason.nvim',
    cmd = {"Mason", "MasonInstall", "MasonUninstall"},
    opts = function ()
      return require'config.varconf'.mason
    end,
    config = function (_, opts)
      require('mason').setup(opts)
    end
  },
  -- =======================================

  -- =======================================
  -- CMP
  { 'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
      -- Snippets
      {'L3MON4D3/LuaSnip',
        dependencies = 'rafamadriz/friendly-snippets',
        config = function ()
          require'config.varconf'.luasnip()
        end
      },
      -- Autopairs
      { 'windwp/nvim-autopairs',
      opts = function ()
        return require'config.varconf'.autopairs
      end,
      config = function (_, opts)
        require('nvim-autopairs').setup(opts)
        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        require('cmp').event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
      },
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function ()
      return require'config.cmpconf'
    end,
    config = function (_, opts)
      require('cmp').setup(opts)
    end,
  },
  -- =======================================

  -- =======================================
  -- Visual --
  -- =======================================

  -- =======================================
  -- Treesitter
  { 'nvim-treesitter/nvim-treesitter',
    init = lazy_load "nvim-treesitter",
    dependencies = {
      -- Blankline
      { 'lukas-reineke/indent-blankline.nvim',
        init = function()
          lazy_load "indent-blankline.nvim"
        end,
        opts = function()
          return require'config.varconf'.blankline
        end,
        config = function(_, opts)
          require('indent_blankline').setup(opts)
        end,
      },
    },
    opts = function ()
      return require'config.varconf'.treesitter
    end,
    build = ":TSUpdate",
    config = function (_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end
  },
  -- =======================================

  -- =======================================
  -- Icons
  { "nvim-tree/nvim-web-devicons",
    config = function(_, opts)
      require('nvim-web-devicons').setup(opts)
    end,
  },
  -- =======================================

  -- =======================================
  -- File explorer
  { 'nvim-tree/nvim-tree.lua',
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require 'config.ntreeconf'
    end,
    config = function(_, opts)
      require('nvim-tree').setup(opts)
    end,
  },
  -- =======================================

  -- =======================================
  -- Theme
  { 'folke/tokyonight.nvim',
    opts = function ()
      return require'config.msconf'.tokyonight
    end,
    config = function (_, opts)
      require('tokyonight').setup(opts)
    end
  },
  -- =======================================

  -- =======================================
  -- Colorizer
  { 'NvChad/nvim-colorizer.lua',
    init = lazy_load "nvim-colorizer.lua",
    opts = function ()
      return require'config.msconf'.colorizer
    end,
    config = function (_, opts)
      require('colorizer').setup(opts)
      vim.defer_fn(function()
        require('colorizer').attach_to_buffer(0)
      end, 0)
    end
  },
  -- =======================================

  -- =======================================
  -- NeoVim Lines and tabs
  { 'rebelot/heirline.nvim',
    lazy = false,
    dependencies = {
      { 'lewis6991/gitsigns.nvim',
        opts = function ()
          return require'config.varconf'.gitsigns
        end,
        config = function (_, opts)
          require('gitsigns').setup(opts)
        end
      },
    },
    config = function ()
      require'config.heirconf'
    end
  }
  -- =======================================
}

-- =======================================
-- Init --
local lazy_config = require'config.varconf'.lazy_nvim
require('lazy').setup(plugins, lazy_config)
-- =======================================
