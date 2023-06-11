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
-- -- Quick way to get to Normal mode without moving off home row
-- Disable for Insert mode cuz better-escape plugin handles that.
-- map('i', 'jk', '<ESC>')
-- map('i', 'kj', '<ESC>')
map('c', 'jk', '<ESC>')
map('c', 'kj', '<ESC>')
map('o', 'jk', '<ESC>')
map('o', 'kj', '<ESC>')
-- Ugh, disable for visual because it makes vertical movements delayed, by timeoutlen,
-- which makes it hard to select the right number of lines.
-- map('x', 'jk', '<ESC>')
-- map('x', 'kj', '<ESC>')

-- I like typing the "colon" without shift!
vim.cmd([[nnoremap ; :]])
-- NOTE: Lua equivalent mapping doesn't update screen, so you don't see the : even though
-- it works functionally: map('n', ';', ':')

-- But I sometimes want what ; did originally, i.e. Repeat the last motion.
map('n', '<CR>', ';')
-- But I need <CR> to do what its normal action in quickfix or loclist, so use
-- an autocmd to undo this locally to the each quickfix & loclist buffer. Initially,
-- I tried to remove the <CR> mapping for the buffer, but that just made it fall back
-- to the non-buffer-specific mapping of <CR> to ';' seen above. Instead I want <CR>
-- do whatever its builtin function is, so map it to itself with nnoremap.
vim.cmd([[
augroup UnmapCRInQuickfixOrLocList
  autocmd!
  autocmd BufWinEnter quickfix,loclist nnoremap <buffer> <CR> <CR>
augroup END
]])

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

-- Make the wildmenu behave sanely. The default mappings assume your wildmenu
-- is layed out horizontally. But we have it configured vertically (by including 'pum'
-- in wildoptions), so the default bindings are very confusing.
-- Also, while the wildmenu is visibile, remap enter to down so that enter can
-- be used to advance to the next submenu (rather than open the selected
-- file/directory).
vim.cmd([[
  cnoremap <expr> <Up>    pumvisible() ? "\<Left>"  : "\<Up>"
  cnoremap <expr> <Down>  pumvisible() ? "\<Right>" : "\<Down>"
  cnoremap <expr> <Left>  pumvisible() ? "\<Up>"    : "\<Left>"
  cnoremap <expr> <Right> pumvisible() ? "\<Down>"  : "\<Right>"
  cnoremap <expr> <CR> pumvisible() ? "\<Down>"  : "\<CR>"
]])
-- NOTE: Due to probable bug as of Nvim v0.6.1, the equivalent Lua mappings,
-- listed here, work functionally but cause rendering problems, so stick to Vim syntax for now:
-- map('c', '<Up>',    'pumvisible() ? "\\<Left>"  : "\\<Up>"',    {expr = true})
-- map('c', '<Down>',  'pumvisible() ? "\\<Right>" : "\\<Down>"',  {expr = true})
-- map('c', '<Left>',  'pumvisible() ? "\\<Up>"    : "\\<Left>"',  {expr = true})
-- map('c', '<Right>', 'pumvisible() ? "\\<Down>"  : "\\<Right>"', {expr = true})

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

-- Move current line or selection up/down
map('n', "<M-Down>", ":m .+1<CR>==")
map('n', "<M-Up>",   ":m .-2<CR>==")

map('x', "<M-Down>", ":move '>+1<CR>gv-gv")
map('x', "<M-Up>",   ":move '<-2<CR>gv-gv")

map('i', "<M-Down>", "<Esc>:m .+1<CR>==gi")
map('i', "<M-Up>",   "<Esc>:m .-2<CR>==gi")

-- Keep the current search hit line centered. TODO: Do I really want this?
-- Also open any fold necessary to see the line containing the current search hit.
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Keep cursor on current column when joining lines. TODO: Do I really want this?
map('n', 'J', 'mzJ`z')

-- If I go up or down with a large count, add the starting point to jumplist
map('n', 'k', [[(v:count > 8 ? "m'" . v:count : "") . "k"]], { expr = true })
map('n', 'j', [[(v:count > 8 ? "m'" . v:count : "") . "j"]], { expr = true })

-- Add quotes, parens, etc around selection
map('v', [[<leader>']], [[<esc>`>a'<esc>`<i'<esc>]])
map('v', [[<leader>"]], [[<esc>`>a"<esc>`<i"<esc>]])
map('v', [[<leader>(]], [[<esc>`>a)<esc>`<i(<esc>]])
map('v', [[<leader>[]], [[<esc>`>a]<esc>`<i[<esc>]])
map('v', [[<leader>{]], [[<esc>`>a}<esc>`<i{<esc>]])

-- Next, prev buffer
map('n', ']b', ':bnext<CR>')
map('n', '[b', ':bprev<CR>')
-- Next, prev file in arg list
map('n', ']a', ':next<CR>')
map('n', '[a', ':Next<CR>')

-- [Telescope Mappings]
-- All start with <leader>s, where s stands for teleScope or "search".  Used to just start with 's'
-- without the leader, but want to free 's' to work with leap.nvim
--map("n", "", ":Telescope autocommands<cr>")
map("n", "<leader>sb", ":Telescope buffers<cr>")
map("n", "<leader>sS", ":Telescope builtin<cr>")
--map("n", "", ":Telescope colorscheme<cr>")
map("c", "<A-r>", ":Telescope command_history<cr>")  -- Can't use more intuitive C-r; would mask "paste register"
map("c", "<A-c>", ":Telescope commands<cr>")         -- Avoid cmd-mode mappings that start with s because that inserts 's'
map("n", "<leader>s/", ":Telescope current_buffer_fuzzy_find<cr>")
map("n", "<leader>s]", ":Telescope current_buffer_tags<cr>")
map("n", "<leader>ssf", ":Telescope file_browser<cr>")
--map("n", "", ":Telescope filetypes<cr>")
map("n", "<leader>sf", ":Telescope find_files hidden=true<cr>")
map("n", "<leader>sgC", ":Telescope git_bcommits<cr>")
map("n", "<leader>sgb", ":Telescope git_branches<cr>")
map("n", "<leader>sgc", ":Telescope git_commits<cr>")
map("n", "<leader>sgf", ":Telescope git_files<cr>")
map("n", "<leader>sgt", ":Telescope git_stash<cr>")
map("n", "<leader>sgs", ":Telescope git_status<cr>")
map("n", "<leader>s*", ":Telescope grep_string<cr>")
map("n", "<leader>sh", ":Telescope help_tags<cr>")
--map("n", "", ":Telescope highlights<cr>")
map("n", "<leader>sj", ":Telescope jumplist<cr>")
map("n", "<leader>sk", ":Telescope keymaps<cr>")
map("n", "<leader>sg", ":Telescope live_grep<cr>")
map("n", "<leader>sl", ":Telescope loclist<cr>")
map("n", "<leader>sa", ":Telescope lsp_code_actions<cr>")
--map("n", "", ":Telescope lsp_definitions<cr>")
map("n", "<leader>se", ":Telescope lsp_document_diagnostics<cr>")
map("n", "<leader>sy", ":Telescope lsp_document_symbols<cr>")
--map("n", "", ":Telescope lsp_dynamic_workspace_symbols<cr>")
map("n", "<leader>si", ":Telescope lsp_implementations<cr>")
map("v", "<leader>sa", ":Telescope lsp_range_code_actions<cr>")
map("n", "<leader>sr", ":Telescope lsp_references<cr>")
--map("n", "", ":Telescope lsp_type_definitions<cr>")
map("n", "<leader>swe", ":Telescope lsp_workspace_diagnostics<cr>")
map("n", "<leader>swy", ":Telescope lsp_workspace_symbols<cr>")
--map("n", "", ":Telescope man_pages<cr>")
map("n", "<leader>sm", ":Telescope marks<cr>")
map("n", "<leader>so", ":Telescope oldfiles<cr>")
--map("n", "", ":Telescope pickers<cr>")
--map("n", "", ":Telescope planets<cr>")
map("n", "<leader>sq", ":Telescope quickfix<cr>")
map("n", "<leader>sR", ":Telescope registers<cr>")
map("n", "<leader>s<C-r>", ":Telescope registers<cr>")  -- Also use C-r since that is how to paste regs in command mode
--map("n", "", ":Telescope reloader<cr>")
map("n", "<leader>s<CR>", ":Telescope resume<cr>")
map("n", "<leader>ss/", ":Telescope search_history<cr>")
--map("n", "", ":Telescope spell_suggest<cr>")
--map("n", "", ":Telescope symbols<cr>")
map("n", "<leader>ss]", ":Telescope tags<cr>")
--map("n", "", ":Telescope tagstack<cr>")
map("n", "<leader>sts", ":Telescope treesitter<cr>")
map("n", "<leader>svo", ":Telescope vim_options<cr>")

-- See Syntax Highlight under Cursor in a pop-up windows
map("n", "<F12>", ":TSHighlightCapturesUnderCursor<cr>")

-- [Harpoon Mappings]
map("n", "<leader>m", ":lua require('harpoon.mark').add_file()<CR>")
map("n", "<A-m>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
map("n", "<A-j>", ":lua require('harpoon.ui').nav_next()<CR>")
map("n", "<A-k>", ":lua require('harpoon.ui').nav_prev()<CR>")
map("n", "<leader>0", ":lua require('harpoon.ui').nav_file(0)<CR>")
map("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>")
map("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>")
map("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>")
map("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>")
map("n", "<leader>5", ":lua require('harpoon.ui').nav_file(5)<CR>")
map("n", "<leader>6", ":lua require('harpoon.ui').nav_file(6)<CR>")
map("n", "<leader>7", ":lua require('harpoon.ui').nav_file(7)<CR>")
map("n", "<leader>8", ":lua require('harpoon.ui').nav_file(8)<CR>")
map("n", "<leader>9", ":lua require('harpoon.ui').nav_file(9)<CR>")

-- [Gitsigns Mappingsa]
-- These are mapped in gitsigns.lua because they use a gitsigns-specific interface to define them

-- [Mappings Tab Pages]
map("n", "gh", ":tabprev<CR>")
map("n", "gl", ":tabnext<CR>")

map("n", "gH", ":tabfirst<CR>")
map("n", "gL", ":tablast<CR>")
-- Don't want to override gn
map("n", "g<Enter>", ":tabnew<CR>")
map("n", "gc", ":tabclose<CR>")

-- Override start Select mode blockwise)
map("n", "g<C-H>", ":tabmove -1<CR>")
map("n", "g<C-L>", ":tabmove +1<CR>")

-- Functions to move current window to next / prev tab, since not built-in
-- From: http://vim.wikia.com/wiki/Move_current_window_between_tabs
-- TODO: Rewrite in Lua?
vim.cmd([[
function! MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
    wincmd j
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function! MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < l:tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
    wincmd j
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
]])

-- Previous mapping for move tab is hard to enter fast enough due to timeoutlen
-- being short. TODO: Seems that which-key should effectively make the delay
-- for g+any key indefinite. But, although it recognizes and displays these
-- mappings, it doesn't recognize them. Dunno why.
map("n", "g<M-l>", ":call MoveToNextTab()<CR>")
map("n", "g<M-h>", ":call MoveToPrevTab()<CR>")
-- For now, we'll also add mappings that start with <M-g>. This still seems to
-- confuse which-key which displays the same hints as for ordinary 'g'.
-- However, this is much easier to type fast, so it's not a big problem in
-- practice.
map("n", "<M-g><M-l>", ":call MoveToNextTab()<CR>")
map("n", "<M-g><M-h>", ":call MoveToPrevTab()<CR>")
