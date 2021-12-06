local onedarkpro = require('onedarkpro')
local utils = require('onedarkpro.utils')
-- See http://neovimcraft.com/plugin/olimorris/onedark.nvim/index.html
local colors = {
  -- Unless otherwise noted, these are same as the theme. Copied here so can reference below.
  bg = "#000028",     -- Darker and bluer than the theme
  red = "#e06c75",
  yellow = "#e5c07b",
  green = "#98c379",
  cyan = "#56b6c2",
  blue = "#61afef",
  black = "#1e1e1e",
  selection = "#002080", -- Much Bluer than the medium gray in the theme
  -- Extra colors not in theme. Reference below.
  blacker = "#0a0a0a",
  brightred = "#f04040",
}
colors.color_column = utils.lighten(colors.bg, 0.97)
colors.cursorline = utils.lighten(colors.bg, 0.95)

onedarkpro.setup({
  colors = colors,
  hlgroups = {
    CursorColumn = { bg = colors.cursorline }, -- NOTE: {link = 'CursorLine'} doesn't work because the original bg= key is still present after the table merge!
    IncSearch = { fg = colors.bg, bg = colors.red },
    Search = { fg = colors.bg, bg = colors.green },
    SignColumn = { bg = colors.blacker },
    Error = { fg = colors.brightred },
--    LspDiagnosticsDefaultError = { fg = "#0000FF", bg = "#800000" },
    LspDiagnosticsSignError = { fg = "#FFFFFF", bg = "#800000", style="bold" },
    LspDiagnosticsSignWarning = { fg = "#FFFFFF", bg = utils.darken(colors.yellow, 0.5) },
    LspDiagnosticsSignInformation = { fg = "#FFFFFF", bg = utils.darken(colors.blue, 0.5) },
    LspDiagnosticsSignHint = { fg = "#FFFFFF", bg = utils.darken(colors.cyan, 0.5) },
--    LspDiagnosticsVirtualTextError = { fg="#FFFFFF", bg="#FF0000" },
  },
  options = {
    cursorline = true,
  },
})
onedarkpro.load()

-- Make it real obvious when we're in Insert mode by changing background
-- Would rather this be local to current window only, but there
-- doesn't seem to be a way to control the definition of the Normal highlight
-- on a per-window basis. I would also prefer the background to be a very
-- dark red, but the darkest possile is still too bright.
vim.cmd([[
augroup ToggleBackgroundInInsertMode
    au!
    au InsertEnter * :highlight Normal guibg=#100000
    au InsertLeave * :highlight Normal guibg=#000028
augroup END
]])
