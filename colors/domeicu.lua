-- clear existing highlights and set colorscheme name
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.o.termguicolors = true
vim.g.colors_name = "domeicu"

local palette = {
  bg_dark      = "#070707", -- Activity bar / absolute darkest
  bg_base      = "#0E0E0D", -- Editor / sidebar / terminal
  fg_cream     = "#CCC8C2", -- Primary text / variables
  fg_mocha     = "#6B6B68", -- Comments / secondary text
  matcha_acc   = "#F1FFD9", -- Keywords / Strings / Functions
  matcha_sub   = "#C0CFA7", -- Numbers / Constants / Structs / Types
  selection    = "#1E1E1C", -- Visual selection
  matcha_trans = "#171F0E", -- Word highlight background
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- =========================================
-- UI Elements
-- =========================================
hi("Normal",       { fg = palette.fg_cream, bg = palette.bg_base })
hi("NormalFloat",  { fg = palette.fg_cream, bg = palette.bg_dark })
hi("FloatBorder",  { fg = palette.fg_mocha, bg = palette.bg_dark })
hi("ColorColumn",  { bg = palette.bg_dark })
hi("Cursor",       { fg = palette.bg_base, bg = palette.matcha_acc })
hi("CursorLine",   { bg = palette.bg_dark })
hi("CursorLineNr", { fg = palette.matcha_acc, bg = palette.bg_dark, bold = true })
hi("LineNr",       { fg = palette.fg_mocha, bg = palette.bg_base })
hi("SignColumn",   { bg = palette.bg_base })
hi("Visual",       { bg = palette.selection })
hi("Search",       { fg = palette.bg_base, bg = palette.matcha_acc })
hi("IncSearch",    { fg = palette.bg_base, bg = palette.matcha_sub })
hi("VertSplit",    { fg = palette.bg_dark, bg = palette.bg_base })
hi("WinSeparator", { fg = palette.bg_dark, bg = palette.bg_base })
hi("StatusLine",   { fg = palette.fg_cream, bg = palette.bg_dark })
hi("StatusLineNC", { fg = palette.fg_mocha, bg = palette.bg_dark })
hi("Pmenu",        { fg = palette.fg_cream, bg = palette.bg_dark })
hi("PmenuSel",     { fg = palette.bg_base, bg = palette.matcha_acc })
hi("MatchParen",   { fg = palette.matcha_acc, bg = palette.matcha_trans, bold = true })
hi("Directory",    { fg = palette.matcha_acc })

-- =========================================
-- Syntax Highlighting
-- =========================================
hi("Comment",      { fg = palette.fg_mocha, italic = true })
hi("String",       { fg = palette.matcha_acc })
hi("Number",       { fg = palette.matcha_sub })
hi("Float",        { fg = palette.matcha_sub })
hi("Boolean",      { fg = palette.matcha_sub })
hi("Constant",     { fg = palette.matcha_sub })

hi("Identifier",   { fg = palette.fg_cream })
hi("Function",     { fg = palette.matcha_acc })
hi("Statement",    { fg = palette.matcha_acc })
hi("Conditional",  { fg = palette.matcha_acc })
hi("Repeat",       { fg = palette.matcha_acc })
hi("Operator",     { fg = palette.fg_cream })
hi("Keyword",      { fg = palette.matcha_acc })
hi("Exception",    { fg = palette.matcha_acc })

hi("PreProc",      { fg = palette.matcha_acc })
hi("Type",         { fg = palette.matcha_sub })
hi("Structure",    { fg = palette.matcha_sub })
hi("Typedef",      { fg = palette.matcha_sub })

hi("Special",      { fg = palette.matcha_acc })
hi("Underlined",   { underline = true })
hi("Error",        { fg = palette.bg_base, bg = "#FF5370" })
hi("Todo",         { fg = palette.matcha_acc, bg = palette.bg_dark, bold = true })

-- =========================================
-- Treesitter (Neovim 0.8+)
-- =========================================
hi("@variable",          { fg = palette.fg_cream })
hi("@variable.builtin",  { fg = palette.matcha_sub, italic = true })
hi("@function",          { fg = palette.matcha_acc })
hi("@function.builtin",  { fg = palette.matcha_acc, italic = true })
hi("@keyword",           { fg = palette.matcha_acc })
hi("@operator",          { fg = palette.fg_cream })
hi("@type",              { fg = palette.matcha_sub })
hi("@type.builtin",      { fg = palette.matcha_sub })
hi("@property",          { fg = palette.matcha_sub })
hi("@parameter",         { fg = palette.matcha_sub })
hi("@punctuation.bracket",{ fg = palette.fg_cream })
hi("@punctuation.delimiter",{ fg = palette.fg_cream })
hi("@string",            { fg = palette.matcha_acc })
hi("@number",            { fg = palette.matcha_sub })
hi("@boolean",           { fg = palette.matcha_sub })
hi("@constant",          { fg = palette.matcha_sub })
hi("@tag",               { fg = palette.matcha_acc })
hi("@tag.attribute",     { fg = palette.matcha_sub })

-- =========================================
-- Common Plugins (Telescope, NvimTree)
-- =========================================
hi("TelescopeNormal",       { fg = palette.fg_cream })
hi("TelescopeBorder",       { fg = palette.fg_mocha })
hi("TelescopePromptNormal", { fg = palette.fg_cream })
hi("TelescopePromptBorder", { fg = palette.fg_mocha })
hi("TelescopeSelection",    { bg = palette.selection })

hi("NvimTreeNormal",        { fg = palette.fg_cream, bg = palette.bg_base })
hi("NvimTreeEndOfBuffer",   { fg = palette.bg_base, bg = palette.bg_base })
hi("NvimTreeVertSplit",     { fg = palette.bg_dark, bg = palette.bg_base })
hi("NvimTreeFolderName",    { fg = palette.matcha_acc })
hi("NvimTreeOpenedFile",    { fg = palette.matcha_acc, bold = true })
