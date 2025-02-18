-- Set the name of this colorscheme
vim.g.colors_name = "bigblue"

-- Ensure we have truecolor mode on
vim.o.termguicolors = true

-- Define a table of all relevant colors
local colors = {
  -- Standard (dark) ANSI colors
  terminal_color_0  = "#51576d", -- black
  terminal_color_1  = "#e78284", -- red
  terminal_color_2  = "#a6d189", -- green
  terminal_color_3  = "#e5c890", -- yellow
  terminal_color_4  = "#8caaef", -- blue
  terminal_color_5  = "#f4b8e4", -- magenta
  terminal_color_6  = "#81c8be", -- cyan
  terminal_color_7  = "#b5bfe2", -- white

  -- Bright ANSI colors
  terminal_color_8  = "#626880", -- bright black
  terminal_color_9  = "#e78284", -- bright red
  terminal_color_10 = "#a6d189", -- bright green
  terminal_color_11 = "#e5c890", -- bright yellow
  terminal_color_12 = "#8caaef", -- bright blue
  terminal_color_13 = "#f4b8e4", -- bright magenta
  terminal_color_14 = "#81c8be", -- bright cyan
  terminal_color_15 = "#a5adce", -- bright white

  -- UI / special
  bg               = "#454d71",
  fg               = "#ffffff",
  selection        = "#626880",
  selection_text   = "#c6d0f5",
  cursor           = "#f2d5cf",
}

-- Assign Neovim's g:terminal_color_{0..15} from our table
for i = 0, 15 do
  local color_name = "terminal_color_" .. i
  vim.g[color_name] = colors[color_name]
end

-------------------------------------------------------------------
-- Highlights
-------------------------------------------------------------------
-- A helper function to set highlights quickly
local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Normal text
hl("Normal", { fg = colors.fg, bg = colors.bg })

-- Visual mode selection
hl("Visual", { fg = colors.selection_text, bg = colors.selection })

-- Cursor color (in GUIs/terminals that support it) 
-- Usually just helps with the internal Neovim cursor highlight
hl("Cursor", { fg = colors.bg, bg = colors.cursor })

-- For the cursor line highlight
hl("CursorLine", { bg = "#3b4252" })  -- pick something you like
hl("CursorLineNr", { fg = "#c6d0f5", bold = true })

-- Comment: pick a subtle color
hl("Comment", { fg = "#626880", italic = true })

-- Add any other highlight groups you want ...

-------------------------------------------------------------------
-- Telescope highlights
-------------------------------------------------------------------
-- Example background choices
local telescope_bg     = "#3b4252"
local telescope_prompt = "#51576d"

hl("TelescopeNormal",        { bg = telescope_bg,     fg = colors.fg })
hl("TelescopeBorder",        { bg = telescope_bg,     fg = colors.terminal_color_0 })
hl("TelescopePromptNormal",  { bg = telescope_prompt, fg = colors.fg })
hl("TelescopePromptBorder",  { bg = telescope_prompt, fg = telescope_prompt })
hl("TelescopePromptPrefix",  { bg = telescope_prompt, fg = colors.terminal_color_1 })
hl("TelescopePromptTitle",   { bg = colors.terminal_color_1, fg = colors.bg, bold = true })
hl("TelescopeResultsTitle",  { bg = telescope_bg, fg = colors.terminal_color_4, bold = true })
hl("TelescopePreviewTitle",  { bg = telescope_bg, fg = colors.terminal_color_2, bold = true })
hl("TelescopeResultsNormal", { bg = telescope_bg, fg = colors.fg })
hl("TelescopeResultsBorder", { bg = telescope_bg, fg = telescope_bg })
hl("TelescopePreviewNormal", { bg = telescope_bg, fg = colors.fg })
hl("TelescopePreviewBorder", { bg = telescope_bg, fg = telescope_bg })

hl("TelescopeSelection",      { bg = colors.selection, fg = colors.selection_text })
hl("TelescopeSelectionCaret", { bg = colors.selection, fg = colors.terminal_color_1 })
hl("TelescopeMultiSelection", { bg = telescope_bg,     fg = colors.terminal_color_4 })

