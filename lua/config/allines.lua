-- ====================================
--          Heirline Config          --

-- ====================================
-- Aliases --
local colors = require('tokyonight.colors').setup()
local cond = require('heirline.conditions')
local uts = require('heirline.utils')
-- ====================================

-- ====================================
--            Components             --


-- ====================================
-- Separator Module
local stheme = function (bgcolor, fgcolor)
    return { bg = bgcolor, fg = bgcolor }
end
local separator = function (direction, thick)
    -- Left
    if direction == "left" and thick == "light" then
      return { provider = '', }
    elseif direction == "left" and thick == "heavy" then
      return { provider = '', }
    end
    -- Right
    if direction == "right" and thick == "light"then
      return { provider = '', }
    elseif direction == "right" and thick == "heavy" then
      return { provider = '', }
    end
end
-- ====================================


-- ====================================
-- VI mode
local vimodes = {
  init = function(self)
    self.mode = vim.fn.mode(1)
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
      n = "red" ,
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
  -- Icon and text
  {
    provider = ' ',
    hl = function (self)
      local mode = self.mode:sub(1, 1)
      return { bg = "bg_dark", fg = self.mode_colors[mode], bold = true, }
    end
  },
  {
    provider = function (self)
      return "%4("..self.mode_names[self.mode].."%) "
    end,
    hl = function (self)
    local mode = self.mode:sub(1, 1)
    return { bg = "bg_dark", fg = self.mode_colors[mode], bold = true, }
    end
  },
  {
    provider = ' 󰘧 ',
    hl = function (self)
      local mode = self.mode:sub(1, 1)
      return { bg = self.mode_colors[mode], fg = "bg", bold = true, }
    end
  },
  {
    provider = ' ',
    hl = function (self)
      local mode = self.mode:sub(1, 1)
      return { fg = self.mode_colors[mode], bold = true, }
    end
  },
  update = { "ModeChanged", pattern = "*:*" },
}
-- ====================================


-- ====================================
-- Files
local files = {
  init = function (self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  -- File Icon
  {
    init = function (self)
      local filename = self.filename
      local extension = vim.fn.fnamemodify(filename, ":e")
      self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    end,
    provider = function (self)
      return self.icon and (self.icon .. " ")
    end,
    hl = function (self)
      return { fg = self.icon_color }
    end
  },
  -- File Name
  {
    provider = function (self)
      local filename = vim.fn.fnamemodify(self.filename, ":.")
      if filename == "" then return "[Empty]" end
      if not cond.width_percent_below(#filename, 0.25) then
        filename = vim.fn.pathshorten(filename)
      end
      return filename
    end,
    hl = function ()
      if vim.bo.modified then
        return { fg = "cyan", bold = true, force = true}
      else
        return { fg = "white"}
      end
    end
  },
  -- File Flags
  {
    {
      condition = function ()
        return vim.bo.modified
      end,
      provider = "",
      hl = { fg = "green" }
    },
    {
      condition = function ()
        return not vim.bo.modifiable or vim.bo.readonly
      end,
      provider = "",
      hl = { fg = "orange" }
    },
  },
  -- Separator
  {
    separator('right', 'light'),
    stheme('#121', '#fff')
  },
}
-- ====================================


-- ====================================
-- Ruler
local ruler = {
  -- Separator
  {
    provider = ' ',
    hl = { fg = "cyan" }
  },
  -- Lines
  {
    provider = "  %L",
    hl = { fg = "green" }
  },
  -- Mini Separator
  {
    provider = "  ",
    hl = { fg = "cyan" }
  },
  -- Current Line
  {
    provider = " %l",
    hl = { fg = "yellow" }
  },
  -- Separator
  {
    provider = " | ",
    hl = { fg = "cyan" }
  },
  -- Current Colunm
  {
    provider = " %c",
    hl = { fg = "red" }
  },
  -- Mini Separator
  {
    provider = "  ",
    hl = { fg = "cyan" }
  },
  -- Percentaje
  {
    provider = " %p ",
    hl = { fg = "green" }
  },
  -- Separator
  {
    provider = ' ',
    hl = { fg = "cyan" }
  },
}

-- ====================================


-- ====================================
-- LSP
local lsp_active = {
  condition = cond.lsp_attached,
  update = { "LspAttach", "LspDetach" },
  provider = function ()
    local name = {}
    for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      table.insert(name, server.name)
    end
    return "   LSP ".. table.concat(name, " ") .. "  "
  end,
  hl = { fg = "green", bold = true }
}

local diagnostic = {
  condition = cond.has_diagnostics,
  static = {
    error_icon = "  ",
    warn_icon = "  ",
    hint_icon = "  ",
    info_icon = "  ",
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { "DiagnosticChanged", "BufEnter" },
  {
    provider = " ",
    hl = { fg = "yellow"}
  },
  {
    provider = function(self)
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = "red" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = "yellow" },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = "blue" },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = "cyan" },
  },
  {
    provider = " ",
    hl = { fg = "yellow"}
  },
}
-- ====================================


-- ====================================
-- Git
local git = {
  condition = cond.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,
  -- Branch
  {
    provider = function(self)
      return " " .. self.status_dict.head
    end,
    hl = { fg = "gray", bold = true }
  },
  -- Add git
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and (" " .. count)
    end,
    hl = { fg = "cyan" },
  },
  -- Removed git
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and (" " .. count)
    end,
    hl = { fg = "red" },
  },
  -- Changed git
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and (" " .. count)
    end,
    hl = { fg = "orange" },
  },
}
-- ====================================


-- ====================================
-- Groups


local a_component = {
  vimodes,
  files
}

local sline = {
    a_component,
    git,
    diagnostic,
    lsp_active,
    ruler,
}
-- ====================================





-- ====================================
-- Tabline
local TablineBufnr = {
    provider = function(self)
        return tostring(self.bufnr) .. ". "
    end,
    hl = "Comment",
}

-- we redefine the filename component, as we probably only want the tail and not the relative path
local TablineFileName = {
    provider = function(self)
        -- self.filename will be defined later, just keep looking at the example!
        local filename = self.filename
        filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
        return filename
    end,
    hl = function(self)
        return { bold = self.is_active or self.is_visible, italic = true }
    end,
}

-- this looks exactly like the FileFlags component that we saw in
-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
-- also, we are adding a nice icon for terminal buffers.
local TablineFileFlags = {
    {
        condition = function(self)
            return vim.api.nvim_buf_get_option(self.bufnr, "modified")
        end,
        provider = "[+]",
        hl = { fg = "green" },
    },
    {
        condition = function(self)
            return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
                or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
        end,
        provider = function(self)
            if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
                return "  "
            else
                return ""
            end
        end,
        hl = { fg = "orange" },
    },
}

-- Here the filename block finally comes together
local TablineFileNameBlock = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    end,
    hl = function(self)
        if self.is_active then
            return "TabLineSel"
        -- why not?
        -- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
        --     return { fg = "gray" }
        else
            return "TabLine"
        end
    end,
    on_click = {
        callback = function(_, minwid, _, button)
            if (button == "m") then -- close on mouse middle click
                vim.schedule(function()
                    vim.api.nvim_buf_delete(minwid, { force = false })
                end)
            else
                vim.api.nvim_win_set_buf(0, minwid)
            end
        end,
        minwid = function(self)
            return self.bufnr
        end,
        name = "heirline_tabline_buffer_callback",
    },
    TablineBufnr,
    fi, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
    TablineFileName,
    TablineFileFlags,
}

-- a nice "x" button to close the buffer
local TablineCloseButton = {
    condition = function(self)
        return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
    end,
    { provider = " " },
    {
        provider = "",
        hl = { fg = "gray" },
        on_click = {
            callback = function(_, minwid)
                vim.schedule(function()
                    vim.api.nvim_buf_delete(minwid, { force = false })
                end)
                vim.cmd.redrawtabline()
            end,
            minwid = function(self)
                return self.bufnr
            end,
            name = "heirline_tabline_close_buffer_callback",
        },
    },
}

-- The final touch!
local TablineBufferBlock = uts.surround({ "", "" }, function(self)
    if self.is_active then
        return uts.get_highlight("TabLineSel").bg
    else
        return uts.get_highlight("TabLine").bg
    end
end, { TablineFileNameBlock, TablineCloseButton })

-- and here we go
local BufferLine = uts.make_buflist(
    TablineBufferBlock,
    { provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
    { provider = "", hl = { fg = "gray" } } -- right trunctation, also optional (defaults to ...... yep, ">")
    -- by the way, open a lot of buffers and try clicking them ;)
)
local TabLine = { BufferLine, }
-- ====================================







-- ====================================
-- Setup
require('heirline').setup({
    statusline = sline,
    tabLine = TabLine,
    opts = {
      colors = colors,
      buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
      filetype = { "NvimTree", "dashboard" }
    }
})
vim.o.showtabline = 2
vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
-- ====================================
