function _G.nvim_tree_smart_toggle()
    local buftype = vim.api.nvim_buf_get_option(0, "filetype")
    if buftype == "" then
        vim.cmd "NvimTreeOpen"
    elseif buftype ~= "NvimTree" then
        vim.cmd "NvimTreeFindFile"
    else
        vim.cmd "NvimTreeRefresh"
        vim.cmd "NvimTreeToggle"
    end
end

vim.api.nvim_set_keymap("n", "<C-n>", ":lua nvim_tree_smart_toggle()<CR>", { noremap = true, silent = true } )

--vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_highlight_opened_files = 1

local tree_cb = require("nvim-tree.config").nvim_tree_callback

require("nvim-tree").setup {
    hijack_cursor = true,
    update_cwd = true,
    hide_dotfiles = false,
    gitignore = true,  -- TODO: Verify this option is working. Maybe the key is wrong?
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    view = {
      width = 30,
      auto_resize = true,  -- TODO: Doesn't seem to work, so set explicit size
      mappings = {
        custom_only = false,
        list = {
          { key = "<C-h>", cb = tree_cb "toggle_dotfiles" }, -- Like ranger. Equiv H
          { key = "u", cb = tree_cb "dir_up" }, -- Old NerdTree mapping. Equiv -
          -- TODO: Map <Right> to expand when on directory (otherwise nothing)
          -- ... and <Left> to collapse directory (Same as <BS>: tree_cb("close_node")
        },
    },
  },
}

require("nvim-tree.events").on_nvim_tree_ready(function()
    vim.cmd "NvimTreeRefresh"
end)

-- - vim.g.nvim_tree_icons = {
-- -     default = "",
-- -     symlink = "",
-- -     git = {
-- -         unstaged = "",
-- -         staged = "✓",
-- -         unmerged = "",
-- -         renamed = "➜",
-- -         untracked = "✗",
-- -     },
-- -     folder = {
-- -         default = "",
-- -         open = "",
-- -         empty = "",
-- -         empty_open = "",
-- -         symlink = "",
-- -     },
-- - }
