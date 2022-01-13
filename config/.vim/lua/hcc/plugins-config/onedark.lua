local onedarkpro = require('onedarkpro')
local utils = require('onedarkpro.utils')
local config = config or require("onedarkpro.config").config

-- See http://neovimcraft.com/plugin/olimorris/onedark.nvim/index.html
local colors = {
  -- Unless otherwise noted, these are same as the theme. Copied here so can reference below.
  bg = "#000038",     -- Darker and bluer than the theme
  -- red = "#e06c75", (Orig)
  red = "#ff4060",
  yellow = "#e5c07b",
  green = "#98c379",
  cyan = "#56b6c2",
  blue = "#61afff",
  black = "#1e1e1e",
  selection = "#002080", -- Much Bluer than the medium gray in the theme
  -- Extra colors not in theme. Reference below.
  blacker = "#0a0a0a",
  brightred = "#f04040",
}
colors.color_column = utils.lighten(colors.bg, 0.97)
colors.cursorline = utils.lighten(colors.bg, 0.95)
local c = colors   -- For brevity

local styles = {
  functions = "NONE", -- This is default, but I need to reference this below.
}

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
    MatchParen = { fg = "#FFFFFF", style = "bold,underline" }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|

    -- This theme has too much red by default, so let's swap some of the red & blue items
    -- Switch these from blue->red:
    TSFunction = { fg = c.red, style = styles.functions }, -- For function (calls and definitions).
    TSInclude = { fg = c.red, style = "italic" }, -- For includes: `#include` in C, `use` or `extern crate` in Rust, or `require` in Lua.
    TSMethod = { fg = c.red }, -- For method calls and definitions.
    TSURI = { fg = c.blue }, -- Any URI like a link or email.
    cssFunctionName = { fg = c.red },
    cssIdentifier = { fg = c.red },
    jsDocParam = { fg = c.red },
    jsFuncCall = { fg = c.red },
    rubyFunction = { fg = c.red },
    rubyInclude = { fg = c.red },

    -- Switch these from red->blue:
    TSField = { fg = c.blue },
    TSParameter = { fg = c.blue, style = "italic" }, -- For parameters of a function.
    TSProperty = { fg = c.blue }, -- Same as `TSField`.
    TSSymbol = { fg = c.blue }, -- For identifiers referring to symbols or atoms.
    TSTag = { fg = c.blue }, -- Tags like html tag names.
    TSVariable = { fg = c.blue, style = config.styles.variables }, -- Any variable name that does not have another highlight.
    cssBraces = { fg = c.blue },
    cssTagName = { fg = c.blue },
    jsSuper = { fg = c.blue },
    jsTemplateBraces = { fg = c.blue },
    jsThis = { fg = c.blue },
    jsonKeyword = { fg = c.blue },
    rubyGlobalVariable = { fg = c.blue },
    rubyInterpolationDelimiter = { fg = c.blue },

  },
  options = {
    cursorline = true,
  },
})
onedarkpro.load()
