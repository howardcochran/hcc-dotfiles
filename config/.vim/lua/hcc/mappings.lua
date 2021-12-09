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

-- Telescope Mappings
map("n", "<C-F>", "<nop>")
map("n", "<C-F><C-F>", ":Telescope find_files<cr>")
map("n", "<C-F><C-G>", ":Telescope live_grep<cr>")
map("n", "<C-F><C-B>", ":Telescope buffers<cr>")
map("n", "<C-F><C-O>", ":Telescope oldfiles<cr>")
map("n", "<C-F><C-H>", ":Telescope help_tags<cr>")
map("n", "<C-F><C-c>", ":Telescope colorscheme<cr>")
map("n", "<C-F><C-P>", ":Telescope project<cr>")
map("n", "<C-F><C-s>", ":SearchSession<cr>")
map("n", "<leader>tf", ":Telescope find_files<cr>")
map("n", "<leader>tg", ":Telescope live_grep<cr>")
map("n", "<leader>tb", ":Telescope buffers<cr>")
map("n", "<leader>to", ":Telescope oldfiles<cr>")
map("n", "<leader>th", ":Telescope help_tags<cr>")
map("n", "<leader>tc", ":Telescope colorscheme<cr>")
map("n", "<leader>tp", ":Telescope project<cr>")
map("n", "<leader>ts", ":SearchSession<cr>")

-- See Syntax Highlight under Cursor in a pop-up windows
map("n", "<F12>", ":TSHighlightCapturesUnderCursor<cr>")
