local lualine = require('lualine')
local sections = {
  lualine_a = {'mode'},
  lualine_b = {'branch'},
  lualine_c = {{'filename', path = 1 }},
  lualine_x = {},
  lualine_y = {'diff', {'diagnostics', sources={'nvim_diagnostic', 'coc'}}, 'filetype'},
  lualine_z = {'progress', 'location'},
}

-- Same as default, but adding path = 1
local inactive_sections = {
  lualine_c = {{'filename', path = 1 }},
  lualine_x = {'diff', {'diagnostics', sources={'nvim_diagnostic', 'coc'}}, 'filetype'},
  lualine_y = {'location'},
}

local my_onedark = require('lualine.themes.onedark')
my_onedark.inactive.a = { fg = my_onedark.normal.c.fg, bg = my_onedark.normal.c.bg, gui = 'bold' }
my_onedark.inactive.b = my_onedark.inactive.a
my_onedark.inactive.c = my_onedark.inactive.a
my_onedark.normal.c = { fg = my_onedark.normal.c.fg, bg = '#005090', gui = 'bold' }
my_onedark.normal.b.gui = 'bold'
my_onedark.insert = my_onedark.replace  -- Make Insert mode stand out more as red

lualine.setup({
  sections = sections,
  inactive_sections = inactive_sections,
  options = { theme = my_onedark },
})
