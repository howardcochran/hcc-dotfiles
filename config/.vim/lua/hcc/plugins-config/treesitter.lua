local treesitter = require "nvim-treesitter.configs"

treesitter.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,  -- Needed for my highlight-trailing-whitespace
  },
}
