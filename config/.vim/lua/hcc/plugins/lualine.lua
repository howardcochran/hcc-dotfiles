local M = {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons', },
}

function M.opts()
  local lualine = require('lualine')

  local sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {{'filename', path = 1 }},
    lualine_x = {},
    lualine_y = {
      'diff',
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' }},
        'filetype'
      },
    lualine_z = {'progress', 'location'},
  }

  local my_onedark = require('lualine.themes.onedark')
  --print(vim.inspect(my_onedark))
--  my_onedark.inactive.b = my_onedark.inactive.a
--  my_onedark.inactive.c = my_onedark.inactive.a
  my_onedark.normal.b.fg = my_onedark.normal.a.bg
  my_onedark.normal.b.bg = '#000060'
  my_onedark.normal.b.gui = 'bold'
  my_onedark.normal.c = { fg = my_onedark.normal.c.fg, bg = '#005090', gui = 'bold' }

  my_onedark.insert.a.bg = '#ff4050'

  my_onedark.inactive.c.fg = my_onedark.normal.c.fg
  my_onedark.inactive.c.gui = 'bold'

  return {
    sections = sections,

    inactive_sections = {
      lualine_c = sections.lualine_c,
      lualine_z = sections.lualine_z,
    },

    options = {
      theme = my_onedark,
    },
    extensions = {
      'nvim-tree',
      'quickfix',
    },
  }
end

return M
