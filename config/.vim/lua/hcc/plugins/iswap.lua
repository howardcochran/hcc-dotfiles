-- Plugin to swap function args, list elements, etc.
local M = {
  'mizlan/iswap.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufReadPost',
}

function M.config()
  require('iswap').setup({
    move_cursor = true,
    auto_swap = true,
  })

  local util = require('hcc.util')

  -- swap arg/list item under cursor with one matching letter typed next (shows highlighted choices)
  util.nmap('<leader>is', ':ISwapWith<CR>')
  -- Same, but for any Treesitter node (e.g. items around an operator)
  util.nmap('<leader>iS', ':ISwapNodeWith<CR>')

  -- swap arg/list item under cursor with next / previous one:
  util.nmap('<M-,>', ':ISwapWithLeft<CR>')
  util.nmap('<M-.>', ':ISwapWithRight<CR>')

  -- swap any Treesitter node under cursor with next / previous one:
  util.nmap('<leader>,', ':ISwapNodeWithLeft<CR>')
  util.nmap('<leader>.', ':ISwapNodeWithRight<CR>')

  -- NOTE: As of June, 2024, not mapping any :IMove commands because they seem very buggy.
end

return M
