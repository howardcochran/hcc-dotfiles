local M = {}

-- mode can either be a single-character string ('n', 'i', etc) or a table of such strings
-- If integer buf given, creates a buffer-specific mapping via nvim_buf_set_keymap ().
-- Otherwise, creates a global mapping.
function M.map(mode, lhs, rhs, opts, buf)
  if type(mode) == table then
    for _, mode_item in ipairs(mode) do
      map(mode_item, lhs, rhs, opts)
    end
  end
  default_opts = { noremap = true, silent = true }
  opts = opts or {}
  opts = vim.tbl_extend('force', default_opts, opts)
  if buf then
    vim.api.nvim_buf_set_keymap(buf, mode, lhs, rhs, opts)
  else
    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

function M.nmap(lhs, rhs, opts)
  M.map('n', lhs, rhs, opts)
end
function M.imap(lhs, rhs, opts)
  M.map('i', lhs, rhs, opts)
end
function M.cmap(lhs, rhs, opts)
  M.map('c', lhs, rhs, opts)
end
function M.vmap(lhs, rhs, opts)
  M.map('v', lhs, rhs, opts)
end
function M.smap(lhs, rhs, opts)
  M.map('s', lhs, rhs, opts)
end
function M.xmap(lhs, rhs, opts)
  M.map('x', lhs, rhs, opts)
end
function M.omap(lhs, rhs, opts)
  M.map('o', lhs, rhs, opts)
end

return M
