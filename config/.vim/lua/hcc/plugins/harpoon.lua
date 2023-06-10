local M = {
  "ThePrimeagen/harpoon",
  lazy = false,
}

function M.config()
  local harpoon = require('harpoon')
  harpoon.setup()

  -- Monkey-patch harpoon to make its menu window be almost the full width of
  -- Vim, because the default is often to narrow to see full deep paths.
  -- NOTE: This won't resize an already-open harpoon menu if Vim's size
  -- changes, but will size it right the next time it is opened.
  local ui = require('harpoon.ui')
  local orig_toggle_quick_menu = ui.toggle_quick_menu

  local function patched_toggle_quick_menu()
    local cfg = harpoon.get_menu_config()
    cfg.width = vim.api.nvim_win_get_width(0) - 16
    if cfg.width < 2 then
      cfg.width = 2
    end
    return orig_toggle_quick_menu()
  end

  ui.toggle_quick_menu = patched_toggle_quick_menu
end

return M
