local M = {
  'kyazdani42/nvim-tree.lua',
  event = 'VimEnter',
}

function M.config()
  require("nvim-tree").setup({
    hijack_cursor = true,
    update_cwd = true,
    actions = {
      open_file = {
        resize_window = false,  -- Do not restore tree width to default when you open a file - that is ANNOYING!
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    filters = {
      dotfiles = true,
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 400,
    },
    renderer = {
      indent_markers = {
        enable = true,
      },
      icons = {
        webdev_colors = true,
        git_placement = "before",
      },
      highlight_opened_files = "icon",
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    view = {
      width = 45,
    },
  })

  -- Key binding to open & close NvimTree:
  vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true } )
end

return M
