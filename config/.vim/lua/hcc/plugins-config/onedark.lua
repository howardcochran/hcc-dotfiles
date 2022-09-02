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
  brightwhite = '#ffffff',
}
colors.color_column = utils.lighten(colors.bg, 0.97)
colors.cursorline = utils.lighten(colors.bg, 0.90)
local c = colors   -- For brevity

local styles = {
  functions = "NONE", -- This is default, but I need to reference this below.
}

onedarkpro.setup({
  colors = colors,
  highlights = {
    CursorColumn = { bg = colors.cursorline }, -- NOTE: {link = 'CursorLine'} doesn't work because the original bg= key is still present after the table merge!
    IncSearch = { fg = colors.bg, bg = colors.red },
    Search = { fg = colors.bg, bg = colors.green },

    -- Make the Diagnostics signs stand out more
    SignColumn = { bg = colors.blacker },
    LspDiagnosticsSignError = { fg = c.brightwhite, bg = "#800000", style="bold" },
    LspDiagnosticsSignWarning = { fg = c.brightwhite, bg = utils.darken(colors.yellow, 0.5) },
    LspDiagnosticsSignInformation = { fg = c.brightwhite, bg = utils.darken(colors.blue, 0.5) },
    LspDiagnosticsSignHint = { fg = c.brightwhite, bg = utils.darken(colors.cyan, 0.5) },

    -- These match the theme except the theme doesn't set a background for them.
    -- Set it to a dark black to make it clear that it's not normal code:
    LspDiagnosticsVirtualTextError = { fg = colors.brightred, bg = c.blacker },
    LspDiagnosticsVirtualTextWarning = { fg = c.yellow, bg = c.blacker },
    LspDiagnosticsVirtualTextHint = { fg = c.cyan, bg = c.blacker },
    LspDiagnosticsVirtualTextInformation = { fg = c.blue, bg = c.blacker },

    -- This theme's highlight for matching parenthesis doesn't stand out enough.
    MatchParen = { fg = c.brightwhite, style = "bold,underline" },

    -- This theme highlights active Tab page in an unreadable way (purple on light gray!). Fix:
    TabLineFill = { bg = c.blacker },        -- Empty part of tab line (to left of last tab)
    TabLine = { bg = c.black },              -- Unselected tab
    TabLineSel = { fg = c.bg, bg = c.cyan }, -- Selected tab

    -- This theme italicises operators by default, but that makes OR ('|') look like DIVIDE ('/').
    -- Let's make 'em bold instead, so they stand out a little bit.
    Operator = { style = "bold" },

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
    transparency = false,
  },
})
onedarkpro.load()
