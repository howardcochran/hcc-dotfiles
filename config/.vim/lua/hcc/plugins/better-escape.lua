local M = {
  "max397574/better-escape.nvim",
  lazy = false,
  opts = {
    mapping = {"jk", "kj"},

    -- Special timeout for this mapping, different from vim.o.timeout. Minimum allowed: 100.
    timeout = 100,

    -- clear line after escaping if there is only whitespace
    clear_empty_lines = true,
  },
}

return M
