local util = require('hcc.util')
local map = util.map
local nmap = util.nmap
local imap = util.imap
local cmap = util.cmap
local vmap = util.vmap
local smap = util.smap
local xmap = util.xmap
local omap = util.omap

vim.g.mapleader = ' '
-- -- Quick way to get to Normal mode without moving off home row
-- Disable for Insert mode cuz better-escape plugin handles that.
-- imap('jk', '<ESC>')
-- imap('kj', '<ESC>')
cmap('jk', '<ESC>')
cmap('kj', '<ESC>')
omap('jk', '<ESC>')
omap('kj', '<ESC>')
-- Ugh, disable for visual because it makes vertical movements delayed, by timeoutlen,
-- which makes it hard to select the right number of lines.
-- xmap('jk', '<ESC>')
-- xmap('kj', '<ESC>')

-- I like typing the "colon" without shift!
vim.cmd([[nnoremap ; :]])
-- NOTE: Lua equivalent mapping doesn't update screen, so you don't see the : even though
-- it works functionally: nmap(';', ':')

-- But I sometimes want what ; did originally, i.e. Repeat the last motion.
nmap('<CR>', ';')
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
nmap('ZZ', 'zz')
-- Like "Refresh" in a web browser. Center line with cursor and redraw screen.
nmap('<F5>', ':norm zz<CR>:redraw!<CR>:nohl<CR>')

-- Kill current buffer without closing the window that it occupies.
nmap('<leader>c', ':bp<CR>:bd#<CR>')

-- Analogous to C or D; easier to type
nmap('Y', 'y$')

-- I often want to change/copy/delete a word up to next underscore:
nmap('cu',  'ct_')
nmap('yu',  'yt_')
nmap('du',  'dt_')

-- Dont' let single-character deletions clobber the last cut (i.e. " register)
nmap('x', '"-x')

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
-- cmap('<Up>',    'pumvisible() ? "\\<Left>"  : "\\<Up>"',    {expr = true})
-- cmap('<Down>',  'pumvisible() ? "\\<Right>" : "\\<Down>"',  {expr = true})
-- cmap('<Left>',  'pumvisible() ? "\\<Up>"    : "\\<Left>"',  {expr = true})
-- cmap('<Right>', 'pumvisible() ? "\\<Down>"  : "\\<Right>"', {expr = true})

-- Really tired of accidentally starting macro recording, so let's make you
-- have to press it twice, like you really mean it!
-- NOTE: I didn't use Q for this because I make that toggle quickfix window
nmap('q', '<Nop>')
nmap('qq', 'q')

-- Keep visual selection when indenting/outdenting
vmap('>', '>gv')
vmap('<', '<gv')

-- Move between windows.
nmap('<C-h>', '<C-W>h')
nmap('<C-j>', '<C-W>j')
nmap('<C-k>', '<C-W>k')
nmap('<C-l>', '<C-W>l')

-- Move current line or selection up/down
nmap("<M-Down>", ":m .+1<CR>==")
nmap("<M-Up>",   ":m .-2<CR>==")

xmap("<M-Down>", ":move '>+1<CR>gv-gv")
xmap("<M-Up>",   ":move '<-2<CR>gv-gv")

imap("<M-Down>", "<Esc>:m .+1<CR>==gi")
imap("<M-Up>",   "<Esc>:m .-2<CR>==gi")

-- Keep the current search hit line centered. TODO: Do I really want this?
-- Also open any fold necessary to see the line containing the current search hit.
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')

-- Keep cursor on current column when joining lines. TODO: Do I really want this?
nmap('J', 'mzJ`z')

-- If I go up or down with a large count, add the starting point to jumplist
nmap('k', [[(v:count > 8 ? "m'" . v:count : "") . "k"]], { expr = true })
nmap('j', [[(v:count > 8 ? "m'" . v:count : "") . "j"]], { expr = true })

-- Add quotes, parens, etc around selection
vmap([[<leader>']], [[<esc>`>a'<esc>`<i'<esc>]])
vmap([[<leader>"]], [[<esc>`>a"<esc>`<i"<esc>]])
vmap([[<leader>(]], [[<esc>`>a)<esc>`<i(<esc>]])
vmap([[<leader>[]], [[<esc>`>a]<esc>`<i[<esc>]])
vmap([[<leader>{]], [[<esc>`>a}<esc>`<i{<esc>]])

-- Next, prev buffer
nmap(']b', ':bnext<CR>')
nmap('[b', ':bprev<CR>')
-- Next, prev file in arg list
nmap(']a', ':next<CR>')
nmap('[a', ':Next<CR>')

-- [Telescope Mappings]
-- All start with <leader>s, where s stands for teleScope or "search".  Used to just start with 's'
-- without the leader, but want to free 's' to work with leap.nvim
--map("n", "", ":Telescope autocommands<cr>")
nmap("<leader>sb", ":Telescope buffers<cr>")
nmap("<leader>sS", ":Telescope builtin<cr>")
--map("n", "", ":Telescope colorscheme<cr>")
map("c", "<A-r>", ":Telescope command_history<cr>")  -- Can't use more intuitive C-r; would mask "paste register"
map("c", "<A-c>", ":Telescope commands<cr>")         -- Avoid cmd-mode mappings that start with s because that inserts 's'
nmap("<leader>s/", ":Telescope current_buffer_fuzzy_find<cr>")
nmap("<leader>s]", ":Telescope current_buffer_tags<cr>")
nmap("<leader>ssf", ":Telescope file_browser<cr>")
--map("n", "", ":Telescope filetypes<cr>")
nmap("<leader>sf", ":Telescope find_files hidden=true<cr>")
nmap("<leader>sgC", ":Telescope git_bcommits<cr>")
nmap("<leader>sgb", ":Telescope git_branches<cr>")
nmap("<leader>sgc", ":Telescope git_commits<cr>")
nmap("<leader>sgf", ":Telescope git_files<cr>")
nmap("<leader>sgt", ":Telescope git_stash<cr>")
nmap("<leader>sgs", ":Telescope git_status<cr>")
nmap("<leader>s*", ":Telescope grep_string<cr>")
nmap("<leader>sh", ":Telescope help_tags<cr>")
--map("n", "", ":Telescope highlights<cr>")
nmap("<leader>sj", ":Telescope jumplist<cr>")
nmap("<leader>sk", ":Telescope keymaps<cr>")
nmap("<leader>sg", ":Telescope live_grep<cr>")
nmap("<leader>sl", ":Telescope loclist<cr>")
nmap("<leader>sa", ":Telescope lsp_code_actions<cr>")
--map("n", "", ":Telescope lsp_definitions<cr>")
nmap("<leader>se", ":Telescope lsp_document_diagnostics<cr>")
nmap("<leader>sy", ":Telescope lsp_document_symbols<cr>")
--map("n", "", ":Telescope lsp_dynamic_workspace_symbols<cr>")
nmap("<leader>si", ":Telescope lsp_implementations<cr>")
map("v", "<leader>sa", ":Telescope lsp_range_code_actions<cr>")
nmap("<leader>sr", ":Telescope lsp_references<cr>")
--map("n", "", ":Telescope lsp_type_definitions<cr>")
nmap("<leader>swe", ":Telescope lsp_workspace_diagnostics<cr>")
nmap("<leader>swy", ":Telescope lsp_workspace_symbols<cr>")
--map("n", "", ":Telescope man_pages<cr>")
nmap("<leader>sm", ":Telescope marks<cr>")
nmap("<leader>so", ":Telescope oldfiles<cr>")
--map("n", "", ":Telescope pickers<cr>")
--map("n", "", ":Telescope planets<cr>")
nmap("<leader>sq", ":Telescope quickfix<cr>")
nmap("<leader>sR", ":Telescope registers<cr>")
nmap("<leader>s<C-r>", ":Telescope registers<cr>")  -- Also use C-r since that is how to paste regs in command mode
--map("n", "", ":Telescope reloader<cr>")
nmap("<leader>s<CR>", ":Telescope resume<cr>")
nmap("<leader>ss/", ":Telescope search_history<cr>")
--map("n", "", ":Telescope spell_suggest<cr>")
--map("n", "", ":Telescope symbols<cr>")
nmap("<leader>ss]", ":Telescope tags<cr>")
--map("n", "", ":Telescope tagstack<cr>")
nmap("<leader>sts", ":Telescope treesitter<cr>")
nmap("<leader>svo", ":Telescope vim_options<cr>")
-- Clipboard history:  mnemonic: ' has to do with registers
nmap("<leader>s'", ":Telescope neoclip default extra=star,plus<cr>")
-- Macro history: mnemonic: 2 is un-shifted @, which has to do with macros. Prefer q, but was taken by quickfix
nmap("<leader>s2", ":Telescope macroscope<cr>")

-- See Syntax Highlight under Cursor in a pop-up windows
nmap("<F12>", ":TSHighlightCapturesUnderCursor<cr>")

-- [Harpoon Mappings]
nmap("<leader>m", ":lua require('harpoon.mark').add_file()<CR>")
nmap("<A-m>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
nmap("<A-j>", ":lua require('harpoon.ui').nav_next()<CR>")
nmap("<A-k>", ":lua require('harpoon.ui').nav_prev()<CR>")
nmap("<leader>0", ":lua require('harpoon.ui').nav_file(0)<CR>")
nmap("<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>")
nmap("<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>")
nmap("<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>")
nmap("<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>")
nmap("<leader>5", ":lua require('harpoon.ui').nav_file(5)<CR>")
nmap("<leader>6", ":lua require('harpoon.ui').nav_file(6)<CR>")
nmap("<leader>7", ":lua require('harpoon.ui').nav_file(7)<CR>")
nmap("<leader>8", ":lua require('harpoon.ui').nav_file(8)<CR>")
nmap("<leader>9", ":lua require('harpoon.ui').nav_file(9)<CR>")

-- [Gitsigns Mappingsa]
-- These are mapped in gitsigns.lua because they use a gitsigns-specific interface to define them

-- [Mappings Tab Pages]
nmap("gh", ":tabprev<CR>")
nmap("gl", ":tabnext<CR>")

nmap("gH", ":tabfirst<CR>")
nmap("gL", ":tablast<CR>")
-- Don't want to override gn
nmap("g<Enter>", ":tabnew<CR>")
nmap("gC", ":tabclose<CR>")  -- Not 'gc' cuz Comment.nvim has mapping that start with 'gc'

-- Override start Select mode blockwise)
nmap("g<C-H>", ":tabmove -1<CR>")
nmap("g<C-L>", ":tabmove +1<CR>")

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
nmap("g<M-l>", ":call MoveToNextTab()<CR>")
nmap("g<M-h>", ":call MoveToPrevTab()<CR>")
-- For now, we'll also add mappings that start with <M-g>. This still seems to
-- confuse which-key which displays the same hints as for ordinary 'g'.
-- However, this is much easier to type fast, so it's not a big problem in
-- practice.
nmap("<M-g><M-l>", ":call MoveToNextTab()<CR>")
nmap("<M-g><M-h>", ":call MoveToPrevTab()<CR>")

-- Map Ctrl-/, a common IDE comment mapping, to Comment.nvim's comment mappings
nmap("<C-_>", "gcc", { noremap = false })
vmap("<C-_>", "gc", { noremap = false })
