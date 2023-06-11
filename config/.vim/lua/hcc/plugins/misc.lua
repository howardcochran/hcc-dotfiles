-- A few misc / small plugins with no configuration required:

M = {
  { 'tpope/vim-repeat', lazy = false },  -- Fix . with other plugins (like leap.nvim)
  { 'tpope/vim-eunuch', lazy = false },
  { 'lambdalisue/suda.vim', lazy = false },
  { 'nvim-tree/nvim-web-devicons', name = 'nvim-web-devicons' },
  -- For some reason, lazy doesn't setup Comment on its own, so provide my own config function here:
  { 'numToStr/Comment.nvim', event = 'BufRead', config = function() require('Comment').setup() end },
}

return M
