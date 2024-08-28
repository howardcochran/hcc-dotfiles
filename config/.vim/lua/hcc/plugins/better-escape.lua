-- Function to clear the line when exiting Insert mode using
-- these mappings if it contains only blanks
local do_esc = function()
  vim.api.nvim_input("<esc>")
  local current_line = vim.api.nvim_get_current_line()
  if current_line:match("^%s+[jk]$") then
    vim.schedule(function()
      vim.api.nvim_set_current_line("")
    end)
  end
end

local M = {
  "max397574/better-escape.nvim",
  lazy = false,

  opts = {
    -- Special timeout for these mappings, different from vim.o.timeout. Minimum allowed: 100.
    timeout = 100,
    default_mappings = false,

    mappings = {
      i = {
        k = { j = do_esc, },
        j = { k = do_esc, },
      },
      c = {
        j = { k = "<Esc>", },
        k = { j = "<Esc>", },
      },
      t = {
        j = { k = "<Esc>", },
        k = { j = "<Esc>", },
      },
      v = {
        -- I had to add the <Up> / <Down> to these visual-mode mappings to compensate
        -- for the down or up that the first character of the mapping did to begin with.
        j = { k = "<Esc><Up>", },
        k = { j = "<Esc><Down>", },
      },
      s = {
        j = { k = "<Esc>", },
        k = { j = "<Esc>", },
      },
    },
  }
}

return M
