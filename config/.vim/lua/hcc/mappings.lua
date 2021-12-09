local function debug_print_tbl(tbl)
  print('{')
  for k, v in pairs(tbl) do
    print('  ', k, ': ', v)
  end
  print('}')
end

local function map(mode, lhs, rhs, opts)
  default_opts = { noremap = true, silent = true }
  opts = opts or {}
  opts = vim.tbl_extend('force', default_opts, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

vim.g.mapleader = ' '
-- Quick way to get to Normal mode without moving off home row
map('i', 'jk', '<ESC>')
map('i', 'kj', '<ESC>')
map('c', 'jk', '<ESC>')
map('c', 'kj', '<ESC>')
map('o', 'jk', '<ESC>')
map('o', 'kj', '<ESC>')
map('x', 'jk', '<ESC>')
map('x', 'kj', '<ESC>')
-- I like typing the "colon" without shift!
map('n', ';', ':')
-- But I sometimes want what ; did originally, i.e. Repeat the last motion.
map('n', '<CR>', ';')

-- Prevent accidental write when capslock is ON
map('n', 'ZZ', 'zz')
-- Like "Refresh" in a web browser. Center line with cursor and redraw screen.
map('n', '<F5>', ':norm zz<CR>:redraw!<CR>:nohl<CR>')

-- Kill current buffer without closing the window that it occupies.
map('n', '<leader>c', ':bp<CR>:bd#<CR>')

-- Analogous to C or D; easier to type
map('n', 'Y', 'y$')

-- I often want to change/copy/delete a word up to next underscore:
map('n', 'cu',  'ct_')
map('n', 'yu',  'yt_')
map('n', 'du',  'dt_')

-- Really tired of accidentally starting macro recording, so let's make you
-- have to press it twice, like you really mean it!
-- NOTE: I didn't use Q for this because I make that toggle quickfix window
map('n', 'q', '<Nop>')
map('n', 'qq', 'q')

-- Keep visual selection when indenting/outdenting
map('v', '>', '>gv')
map('v', '<', '<gv')

-- Move between windows.
map('n', '<C-h>', '<C-W>h')
map('n', '<C-j>', '<C-W>j')
map('n', '<C-k>', '<C-W>k')
map('n', '<C-l>', '<C-W>l')

-- [Telescope Mappings]
-- All start with 's' as in teleScope, since s is just an alias for cl.
map("n", "s", "<nop>")
--map("n", "", ":Telescope autocommands<cr>")
map("n", "sb", ":Telescope buffers<cr>")
map("n", "sS", ":Telescope builtin<cr>")
--map("n", "", ":Telescope colorscheme<cr>")
map("c", "<A-r>", ":Telescope command_history<cr>")  -- Can't use more intuitive C-r; would maks "paste register"
map("c", "<A-c>", ":Telescope commands<cr>")         -- Avoid cmd-mode mappings that start with s because that insers 's'
map("n", "s/", ":Telescope current_buffer_fuzzy_find<cr>")
map("n", "s]", ":Telescope current_buffer_tags<cr>")
map("n", "ssf", ":Telescope file_browser<cr>")
--map("n", "", ":Telescope filetypes<cr>")
map("n", "sf", ":Telescope find_files<cr>")
map("n", "sgC", ":Telescope git_bcommits<cr>")
map("n", "sgb", ":Telescope git_branches<cr>")
map("n", "sgc", ":Telescope git_commits<cr>")
map("n", "sgf", ":Telescope git_files<cr>")
map("n", "sgt", ":Telescope git_stash<cr>")
map("n", "sgs", ":Telescope git_status<cr>")
map("n", "s*", ":Telescope grep_string<cr>")
map("n", "sh", ":Telescope help_tags<cr>")
--map("n", "", ":Telescope highlights<cr>")
map("n", "sj", ":Telescope jumplist<cr>")
map("n", "sk", ":Telescope keymaps<cr>")
map("n", "sg", ":Telescope live_grep<cr>")
map("n", "sl", ":Telescope loclist<cr>")
map("n", "sa", ":Telescope lsp_code_actions<cr>")
--map("n", "", ":Telescope lsp_definitions<cr>")
map("n", "se", ":Telescope lsp_document_diagnostics<cr>")
map("n", "sy", ":Telescope lsp_document_symbols<cr>")
--map("n", "", ":Telescope lsp_dynamic_workspace_symbols<cr>")
map("n", "si", ":Telescope lsp_implementations<cr>")
map("v", "sa", ":Telescope lsp_range_code_actions<cr>")
map("n", "sr", ":Telescope lsp_references<cr>")
--map("n", "", ":Telescope lsp_type_definitions<cr>")
map("n", "swe", ":Telescope lsp_workspace_diagnostics<cr>")
map("n", "swy", ":Telescope lsp_workspace_symbols<cr>")
--map("n", "", ":Telescope man_pages<cr>")
map("n", "sm", ":Telescope marks<cr>")
map("n", "so", ":Telescope oldfiles<cr>")
--map("n", "", ":Telescope pickers<cr>")
--map("n", "", ":Telescope planets<cr>")
map("n", "sq", ":Telescope quickfix<cr>")
map("n", "sR", ":Telescope registers<cr>")
map("n", "s<C-r>", ":Telescope registers<cr>")  -- Also use C-r since that is how to paste regs in command mode
--map("n", "", ":Telescope reloader<cr>")
map("n", "s<CR>", ":Telescope resume<cr>")
map("n", "ss/", ":Telescope search_history<cr>")
--map("n", "", ":Telescope spell_suggest<cr>")
--map("n", "", ":Telescope symbols<cr>")
map("n", "ss]", ":Telescope tags<cr>")
--map("n", "", ":Telescope tagstack<cr>")
map("n", "sts", ":Telescope treesitter<cr>")
map("n", "svo", ":Telescope vim_options<cr>")

-- See Syntax Highlight under Cursor in a pop-up windows
map("n", "<F12>", ":TSHighlightCapturesUnderCursor<cr>")
