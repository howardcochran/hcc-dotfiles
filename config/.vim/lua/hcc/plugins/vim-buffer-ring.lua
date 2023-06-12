-- Finally found a plug-in to let me switch buffers in MRU order! It's an old
-- VimScript one, but still works on Neovim 0.9.1 as of June., 2023.
-- TODO:
-- * Make functions to jump directly to last & first item in the ring and
--   come up with mappings for this.
-- * Make the "buffer wrapped" message timeout after brief time.
local M = {
  'landonb/vim-buffer-ring',
  lazy = false,
}

function M.config()
  map = require('hcc.util').map

  map('n', '<M-h>', '<cmd>:BufferRingReverse<CR>')
  map('n', '<M-l>', '<cmd>:BufferRingForward<CR>')
end

return M
