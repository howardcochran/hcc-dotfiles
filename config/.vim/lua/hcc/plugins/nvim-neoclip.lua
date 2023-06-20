local M = {
  "AckslD/nvim-neoclip.lua",
  -- event = 'TextYankPost',
  lazy = false,
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
}

function M.config()
  require('neoclip').setup({})
  require('telescope').load_extension('neoclip')
  require('telescope').load_extension('macroscope')
end

return M
