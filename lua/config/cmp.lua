-- Plugins Config --
-- cmp
local cmp = require'cmp'

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

local cmp_opt = {
  window = {
    completion = {
      border = border "CmpBorder",
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
    },
    documentation = { border = border "CmpDocBorder" },
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    
    ["<C-Space>"] = cmp.mapping.complete(),
    
    ["<C-e>"] = cmp.mapping.close(),
    
    ["<CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
    
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
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = "nvim_lua" },
    { name = "path" },
  }
}
-- LuaSnip
local luasnip_opt = {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}
  
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function() 
    if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
    then
      require("luasnip").unlink_current()
    end
	end,
})
-- Configs Call --
require('luasnip').config.set_config(luasnip_opt)
require("luasnip.loaders.from_vscode").lazy_load()
require('cmp').setup(cmp_opt)
