local M = {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/playground',
  },
  event = 'BufEnter',
  main = 'nvim-treesitter.configs',
  opts = {
    -- ensure that all parsers are installed
    ensure_installed = 'all',
    -- don't install the comment parser, because this currently
    -- causes big slowdowns with multiline comments
    -- (see https://github.com/nvim-treesitter/nvim-treesitter/issues/3135)
    ignore_install = { 'comment' },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,  -- Needed for my highlight-trailing-whitespace
    },
  },
}

return M
