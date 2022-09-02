local tree_cb = require("nvim-tree.config").nvim_tree_callback

require("nvim-tree").setup {
    hijack_cursor = true,
    update_cwd = true,
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

-- Key binding to open & close NvimTree:
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true } )
