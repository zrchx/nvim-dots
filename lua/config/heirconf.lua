-- ====================================
--          Heirline Config          --

-- ====================================
-- Aliases --
local theme = require("tokyonight.colors").setup()
local conditions = require("heirline.conditions")
--local utils = require("heirline.utils")
local api = vim.api
local fn = vim.fn
-- ====================================

-- ====================================
--            Components             --

-- ====================================
-- Separator Module
local separator = function (direction, pos, bgcolor, fgcolor)
    -- Left sharp
    if direction == "left" and pos == "x" then
      return { provider = " ", hl = {bg = bgcolor, fg = fgcolor}}
    elseif direction == "left" and pos == "y" then
      return { provider = " ", hl = {bg = bgcolor, fg = fgcolor}}
    end
    -- Right sharp
    if direction == "right" and pos == "x" then
      return { provider = " ", hl = {bg = bgcolor, fg = fgcolor}}
    elseif direction == "right" and pos == "y" then
      return { provider = " ", hl = {bg = bgcolor, fg = fgcolor}}
    end
end
-- ====================================

-- ====================================
-- VI mode
local vimodes = {
  init = function(self)
    self.mode = fn.mode(1)
  end,
  static = {
    mode_names = {
      -- Normal Modes
      n = "Normal",
      no = "NormalO",
      nov = "NormalO",
      noV = "NormalO",
      ["no\22"] = "Normal?",
      niI = "NormalI",
      niR = "NormalR",
      niV = "NormalV",
      nt = "NormalT",
      ntT = "NormalT",
      -- Visual Modes
      v = "Visual",
      vs = "VisualS",
      V = "Visual_",
      VS = "Visual_S",
      ["\22"] = "Visual^",
      ["\22s"] = "Visual^",
      -- Select Modes
      s = "Select",
      S = "Select_",
      ["\19"] = "Select^",
      -- Insert Modes
      i = "Insert",
      ic = "InsertC",
      ix = "InsertX",
      -- Replace Modes
      R = "Replace",
      Rc = "ReplaceC",
      Rx = "ReplaceX",
      Rv = "ReplaceV",
      Rvc = "ReplaceV",
      Rvx = "ReplaceV",
      -- Various Modes
      r = "Hit",
      rm = "More",
      ["!"] = "Sc!",
      ["r?"] = "Confirm",
      c = "ComandLine",
      t = "Term",
    },
    -- Colorize modes
    mode_colors = {
      n = "red",
      i = "green",
      v = "cyan",
      V =  "cyan",
      ["\22"] =  "cyan",
      c =  "orange",
      s =  "purple",
      S =  "purple",
      ["\19"] =  "purple",
      R =  "orange",
      r =  "orange",
      ["!"] =  "red",
      t =  "red",
    }
  },
  { -- Icon
    provider = " 󰘧",
    hl = function (self)
      local mode = self.mode:sub(1, 1)
      return { bg = self.mode_colors[mode], fg = "bg_dark", bold = true }
    end
  },
  { -- Text mode
    provider = function (self)
      return " %4("..self.mode_names[self.mode].."%) "
    end,
    hl = function (self)
      local mode = self.mode:sub(1, 1)
      return { bg = self.mode_colors[mode], fg = "bg_dark", bold = true }
    end
  },
  { -- Separator
    provider = " ",
    hl = function (self)
      local mode = self.mode:sub(1, 1)
      return { bg = "bg", fg = self.mode_colors[mode], bold = true }
    end
  },
  update = { "ModeChanged", pattern = "*:*" },
}
-- ====================================

-- ====================================
-- Files
local files = {
  init = function (self)
    self.filename = api.nvim_buf_get_name(0)
  end,
  { -- Separator
    separator("right", "x", "bg", "bg_dark")
  },
  { -- Files icons
    init = function (self)
      local filename = self.filename
      local extension = fn.fnamemodify(filename, ":e")
      self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function (self)
      return self.icon and (" " .. self.icon .. "")
    end,
    hl = function (self)
      return { bg = "bg_dark", fg = self.icon_color }
    end
  },
  { -- Files names
    provider = function (self)
      local filename = " " .. fn.fnamemodify(self.filename, ":.") .. " "
      if filename == "  " then return " [New] " end
      if not conditions.width_percent_below(#filename, 0.25) then
        filename = fn.pathshorten(filename)
      end
      return filename
    end,
    hl = function ()
      if vim.bo.modified then
        return { bg = "bg_dark", fg = "blue", bold = true }
      else
        return { bg = "bg_dark", fg = "gray" }
      end
    end
  },
  { -- Separator
    separator("left", "x", "bg", "bg_dark"),
  },
}
-- ====================================

-- ====================================
-- Ruler
local ruler = {
  { -- Separator
    separator("right", "y", "bg", "bg_dark")
  },
  { -- Current Line
    provider = "  %l :  %c ",
    hl = { bg = "bg_dark", fg = "yellow" }
  },
  {
    conditions = function ()
      return conditions.width_percent_below(3, 0.035)
    end,
    provider = "󰦨 %P",
    hl = { bg = "bg_dark", fg = "blue" }
  }
}
-- ====================================

-- ====================================
-- LSP
local lsp_active = {
  {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach" },
  separator("right", "y", "bg", "bg_dark")
  },
  {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach" },
  provider = "  LSP ",
  hl = { fg = "green", bg = "bg_dark", bold = true },
  },
  {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach" },
  separator("left", "y", "bg", "bg_dark")
  },
}

local diagnostic = {
  condition = conditions.has_diagnostics,
  static = {
    error_icon = "  ",
    info_icon = "  ",
    hint_icon = "  ",
    warn_icon = "  ",
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { "DiagnosticChanged", "BufEnter" },
  -- Errors
  {
    provider = function(self)
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = "red" },
  },
  -- Warnings
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = "yellow" },
  },
  -- Info
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = "blue" },
  },
  -- Hints
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = "cyan" },
  },
}
-- ====================================

-- ====================================
-- Git
local git = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,
  -- Separator
  {
  separator("right", "x", "bg", "bg_dark")
  },
  -- Branch
  {
    provider = function(self)
      return "  " .. self.status_dict.head .. " "
    end,
    hl = { fg = "gray", bg = "bg_dark" ,bold = true }
  },
  -- Separator
  {
  separator("left", "x", "bg", "bg_dark")
  },
  -- Add git
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and ("  " .. count .. " ")
    end,
    hl = { fg = "cyan"},
  },
  -- Removed git
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and (" " .. count .. " ")
    end,
    hl = { fg = "red"},
  },
  -- Changed git
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and (" " .. count .. " ")
    end,
    hl = { fg = "orange" },
  },
}
-- ====================================

-- ====================================
-- Tabline

-- ====================================

-- ====================================
-- Setup
require("heirline").setup({
  statusline = {
    vimodes,
    files,
    git,
    diagnostic,
    lsp_active,
    ruler,
  },
  opts = {
    colors = theme,
  }
})
-- ====================================
