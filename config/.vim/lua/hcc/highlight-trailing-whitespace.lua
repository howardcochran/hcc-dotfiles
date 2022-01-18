-- Highlight trailing whitespace in bright red (except when in Insert mode)
-- This is a almost straight port from my old pre-lua Vim config.

vim.cmd([[
  highlight WhitespaceError guifg=#000000 guibg=#ff0000 guisp=NONE gui=NONE ctermfg=0 ctermbg=196
]])

vim.cmd([[
  function! DisableTrailingWhitespaceMatch()
    if exists('w:trailing_whitespace_match')
      call matchdelete(w:trailing_whitespace_match)
      unlet w:trailing_whitespace_match
    endif
  endfunction

  function! EnableTrailingWhitespaceMatch()
    if !exists('w:trailing_whitespace_match')
      let w:trailing_whitespace_match = matchadd('WhitespaceError', '\s\+$\| \+\ze\t', -1)
      highlight WhitespaceError guifg=#000000 guibg=#ff0000 guisp=NONE gui=NONE ctermfg=0 ctermbg=196
    endif
  endfunction

  " We have to use VimEnter & WinEnter to add the whitespace match separately
  " for each new window. However, it's annoying to see the red as I'm typing
  " so we'll toggle it OFF whenever we are in Insert mode.
  augroup TrailingWhitespaceGroup
    au!
    au VimEnter,WinEnter,InsertLeave * call EnableTrailingWhitespaceMatch()
    au InsertEnter * call DisableTrailingWhitespaceMatch()
  augroup END
]])

vim.o.syntax = 'on'
