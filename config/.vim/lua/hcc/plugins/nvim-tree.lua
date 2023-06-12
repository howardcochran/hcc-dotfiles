local M = {
  'kyazdani42/nvim-tree.lua',
  event = 'VimEnter',
}

function M.config()
  local tree_cb = require("nvim-tree.config").nvim_tree_callback

--  local function on_attach(bufnr)
--    local api = require('nvim-tree.api')
--
--    local function opts(desc)
--      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
--    end
--
--    -- Apply default mappings
--    api.config.mappings.default_on_attach(bufnr)
--
--    vim.keymap.set('n', '<C-h>', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
--    vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
--    -- TODO: Map <Right> to expand when on directory (otherwise nothing)
--    -- ... and <Left> to collapse directory (Same as <BS>: tree_cb("close_node")
--  end

  require("nvim-tree").setup({
--      on_attach = on_attach,
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
