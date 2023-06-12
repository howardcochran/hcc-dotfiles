local M = {
  'stevearc/aerial.nvim',
  lazy = false,
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     "nvim-tree/nvim-web-devicons"
  },

  -- Only setting non-default options:
  opts = {
    layout = {
      placement = 'edge',   -- Take full height of Nvim rather than just current split
    },
    attach_mode = 'global', -- Display symbols for current window rather than the one active when originally opened
    autojump = true,        -- When move in Aerial, jump buffer to position of highlighted symbol

    -- Intriguing, but not quite sold on these:
    -- manage_folds = true,
    -- link_folds_to_tree = true,
    -- link_tree_to_folds = true,
  },
}

local map = require('hcc.util').map
map('n', '<leader>a', '<cmd>:AerialToggle<CR>')

-- Opens a 3-pane pop-up much like "ranger" in a filesystem. Not sure how
-- useful this is, but here's a mapping so we can play with it:
map('n', '<leader>A', '<cmd>:AerialNavToggle<CR>')

return M
