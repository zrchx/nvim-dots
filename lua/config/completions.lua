-- ====================================
--          plugins config           --
-- ====================================
-- CMP --
local cmp = require'cmp'

local icons = {
  Text = ' ',
  Method = '柳',
  Function = '柳',
  Constructor = '柳',
  Field = ' ',
  Variable = ' ',
  Class = ' ',
  Interface = ' ',
  Module = ' ',
  Property = ' ',
  Unit = ' ',
  Value = ' ',
  Enum = ' ',
  Keyword = ' ',
  Snippet = ' ',
  Color = ' ',
  File = '',
  Reference = '',
  Folder = ' ',
  EnumMember = ' ',
  Constant = ' ',
  Struct = ' ',
  Event = '',
  Operator = ' ',
  TypeParameter = ' ',
}

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local options = {
  window = {
    completion = {
      border = border "CmpBorder",
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      scrollbar = false,
    },
    documentation = { border = border "CmpDocBorder", winhighlight = "Normal:CmpDoc" },
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = (icons[vim_item.kind] or '') .. vim_item.kind
      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = "nvim_lua" },
    { name = "path" },
  }
}
return options
