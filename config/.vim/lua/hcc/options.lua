vim.wo.wrap = false
vim.wo.linebreak = false
vim.o.shiftwidth = 4
vim.o.tabstop = 8
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.history = 500
vim.o.ruler = true          -- Always show a window status line, even when only 1 win
vim.o.showcmd = true        -- Show partially typed commands in status area
vim.o.incsearch = true      -- Incremental search
vim.o.inccommand = 'split'  -- Shows incremental results of substitute cmd in split (Nvim only)
vim.o.ignorecase = true     -- the case of normal letters is ignored
vim.o.smartcase = true      -- upper case letters in search turn off ignorecase
vim.o.wrapscan = true       -- wrap to top of file on search
vim.o.showmatch = true      -- When a bracket is inserted, briefly jump to the matching.,s'
vim.o.whichwrap = '<,>,[,],b,s'

vim.o.hlsearch = true
vim.o.gdefault = true       -- assume the /g flag on :s substitutions to replace all matches in a line
vim.o.shell='/bin/zsh'
vim.o.modeline = true
vim.o.modelines = 5
vim.o.showfulltag = true    -- Insert mode completion of tag shows whole funct prototype!
vim.o.hidden = true         -- Vim is completely unusable without this!
vim.o.laststatus = 2        -- Always show a status line, even when only 1 window
vim.o.colorcolumn = '81'
vim.o.swapfile = false      -- Swap files are so annoying!
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorcolumn = true
vim.o.cursorline = true
vim.o.mouse = 'a'
vim.cmd('behave xterm')     -- Mouse drag enters Visual mode instead of Select mode.
                            -- behave sets several options. See help
vim.o.startofline = false   -- Don't gatuitously move cursor to 1st column
vim.o.path = vim.o.path .. '**' -- File operations recurse directories
vim.o.signcolumn = 'auto:6'
vim.o.winminheight = 0

-- New windows open below or to right of current one (why isn't this default?)
vim.o.splitbelow = true
vim.o.splitright = true

-- Format Options
vim.o.formatoptions = vim.o.formatoptions .. 'j' -- Delete comment char when joining commented lines
vim.o.formatoptions = vim.o.formatoptions .. 'c' -- Auto-format comments in insert mode
-- HOW TO REMOVE? vim.o.formatoptions-=o -- (don't) Insert the comment leader after hitting 'o' etc.
vim.o.textwidth = 78
vim.o.updatetime = 300      -- Vim's hover timeout. Default 4000. Want this low for more reactive coc plugins

-- Tighter X server clipboard integration. Of these unnamed and unnamedplus
-- are added to the defaults.
-- This port from vimscript gives Lua error: vim.o.clipboard = 'unnamed,unnamedplus,autoselect,exclude:cons\|linux'
vim.o.clipboard = 'unnamed,unnamedplus'

vim.o.backspace = 'indent,eol,start' -- allow backspacing over everything in insert mode

-- make command line completion work nicely -- complete the longest common
-- string, then list the alternatives in a popup menu, allowing you to cycle
-- between siblings with tab/shift-tab or arrow keys.
vim.o.wildmode = 'longest:full,full'
vim.o.wildmenu = true
vim.o.wildoptions = 'pum,tagfile'  -- pum = Make the wild menu vertical

-- Fix delay exiting insert mode using Esc. Default was 1000ms
-- See https://www.johnhawthorn.com/2012/09/vi-escape-delays/
vim.o.timeoutlen = 200

-- Re-use of existing windows when switching buffers:
vim.o.switchbuf = 'useopen,usetab,split'

-- Be a little bit more Common User Interface-like
vim.o.virtualedit = 'onemore,block'

-- [ C/C++ formatting options ]
-- NOTE: Nvim's Lua :append({'valu'}) syntax didn't work for cinoptions. Why?

-- Indent C++ class declarations & constructor initializations, if they start
-- on a new line, by double the shiftwidth
vim.o.cinoptions = 'i2s'

-- Indent a contination line of a long expression double the shiftwidth.
vim.o.cinoptions = vim.o.cinoptions .. ',+2s'

-- This option must be set for the following two to work (W and m)
vim.o.cinoptions = vim.o.cinoptions .. ',(0'

-- Indent line following a line ending with open-parenthesis double shiftwidth
-- So arguments to a long function call will not start way over to the left,
-- which makes going to a new line pointless!
vim.o.cinoptions = vim.o.cinoptions .. ',W2s'

-- Line up a line starting with a closing parentheses with the first character
-- of the line with the matching opening parentheses
vim.o.cinoptions = vim.o.cinoptions .. ',m1'

-- Align with case label instead of the statement after it
vim.o.cinoptions = vim.o.cinoptions .. ',l1'

-- Use new LUA filetype detection
vim.g.do_filetype_lua = 1

-- Treat .bb and .bbappend files like bash (Not perfect, but reasonable)
vim.filetype.add({
  extension = {
    bb = "bash",
    bbappend = "bash",
  },
})

-- Specify some per-filetype options:
vim.cmd([[
  augroup hcc_indents
  autocmd!
    " hard tabs are special in makefiles, don't expand them
    autocmd FileType make set noexpandtab shiftwidth=8 nowrap
    autocmd FileType c set noexpandtab shiftwidth=8 nowrap
    autocmd FileType xml,cpp set expandtab shiftwidth=2 textwidth=0 colorcolumn=99 nowrap
    autocmd FileType gitcommit set expandtab shiftwidth=4 textwidth=72 colorcolumn=72 wrap
    autocmd FileType md,txt set expandtab shiftwidth=4 textwidth=79 wrap
    autocmd FileType python,sh,perl set expandtab shiftwidth=4 textwidth=0 colorcolumn=99 nowrap
    autocmd FileType lua set expandtab shiftwidth=2 textwidth=0 colorcolumn=99 nowrap
  augroup END
]])
