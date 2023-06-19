-- Provide Zsh-like mappings for insert and command modes (as Zsh is configured
-- in these dot files):
--
-- <M-b>  Move back one WORD (delimited by spaces)
-- <M-f>  Move forward one WORD
-- <C-b>  Move back one word (delimited by any non-word character)
-- <C-f>  Move forward one word
-- <M-BS> Delete back on WORD
-- <C-BS> Delete back one word
--
-- Implementation Notes:
-- Because of i_CTRL-o, this is these are just simple mappings for Insert mode
-- to execute normal mode B, W, b, w, dB, db commands respectively while
-- remaining in insert mode. However, their behavior differs from that of Zsh
-- in subtle ways.
--
-- Command mode (where the author wants these mappings the most) is a whole
-- different story, because there is no analog to i_CTRL-o and only a few of
-- these functions have command-mode commands to map to (c_CTRL-W, c_CTRL-Left,
-- c_CTRL-Right). So, this requires code to modify the cursor position and/or
-- the contents of the command line using vim.fn.getcmdpos(),
-- vim.fn.getcmdline(), and vim.fn.setcmdpos() and vim.fn.setcmdline().
--
-- But actually, when mapping directly to a Lua function, Neovim (as of 0.9.1)
-- will not honor vim.fn.setcmdpos() to set the cursor postion on the cmdline
-- (you can change the command line contents via vim.fn.setcmdline() but not
-- the cursor position! This seems like a bug. The workaround is for the
-- mapping to invoke "replace command line with the result of evaluating an
-- expression (i.e. <C-\>e followed by expression that calls Lua function).
-- When called in that context, vim.fn.setcmdpos() works.

local util = require('hcc.util')

local M = {}
function M.is_WORD_char(s)
  return not s:match('%s')
end


function M.is_word_char(s)
  return not not s:match('[%w_]')  -- "double not" converts to actual boolean
end


function M.find_back_word_pos(s, startpos, test_fcn)
  if #s == 0 or startpos <= 0 then
    return 0
  end
  pos = startpos
  while pos > 1 and not test_fcn(s:sub(pos-1, pos-1)) do
    pos = pos - 1
  end
  while pos > 1 and test_fcn(s:sub(pos-1, pos-1)) do
    pos = pos - 1
  end
  return pos
end

function M.cmdline_back_word(kwargs)
  orig_pos = vim.fn.getcmdpos()
  cmdline = vim.fn.getcmdline()
  test_fcn = kwargs.is_WORD and M.is_WORD_char or M.is_word_char
  new_pos = M.find_back_word_pos(cmdline, orig_pos, test_fcn)

  if kwargs.is_delete then
    -- Since there is no Undo available in command mode, save to the "small cut" register ('-')
    -- so user can "undo" it by typing <C-r>-
    vim.fn.setreg('-', cmdline:sub(new_pos, orig_pos - 1))
    cmdline = cmdline:sub(1, new_pos - 1) .. cmdline:sub(orig_pos)
  end

  vim.fn.setcmdpos(new_pos)
  return cmdline
end

function M.find_forward_word_pos(s, startpos, test_fcn)
  if #s == 0 or startpos >= #s then
    return startpos
  end
  pos = startpos
  while pos < #s + 1 and not test_fcn(s:sub(pos, pos)) do
    pos = pos + 1
  end
  while pos < #s + 1 and test_fcn(s:sub(pos, pos)) do
    pos = pos + 1
  end
  return pos
end

function M.cmdline_forward_word(kwargs)
  orig_pos = vim.fn.getcmdpos()
  cmdline = vim.fn.getcmdline()
  test_fcn = kwargs.is_WORD and M.is_WORD_char or M.is_word_char
  new_pos = M.find_forward_word_pos(cmdline, orig_pos, test_fcn)

  if kwargs.is_delete then
    -- Since there is no Undo available in command mode, save to the "small cut" register ('-')
    -- so user can "undo" it by typing <C-r>-
    vim.fn.setreg('-', cmdline:sub(orig_pos, new_pos - 1))
    cmdline = cmdline:sub(1, orig_pos) .. cmdline:sub(new_pos)
  end

  vim.fn.setcmdpos(new_pos)
  return cmdline
end

-- This somewhat hacky thing requires explanation. Wanted to directly map like this:
-- vim.keymap.set('c', 'M-b', '<C-\\>elueaeval("require(\'hcc.shell-like-mappings\').cmdline_back_word({is_WORD = true, is_delete = false}))')
-- But, although the mapping would "work", Nvim would not update the screen afterward, so you
-- would not actually see the effect on the cmdline until you type another character! I think this
-- is a bug in Neovim. But, based on the fact that performing the same keystrokes manually did
-- update the screen, I decided to try using vim.fn.feedkeys to stuff the keystrokes into the
-- input buffer, and behold, that worked.  Ugly workaround, I know!
-- This helper function makes the mappings in M.setup() less ugly by generating a function that
-- varies only in the passed "code" string.
function M.make_feedkeys_caller(code)
  return function()
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-\\>eluaeval("require(\'hcc.shell-like-mappings\').' .. code .. '")<CR>', true, true, true), 'nt')
  end
end

function M.setup()
  -- Zsh-like mappings for Insert mode:
  util.imap('<M-b>', '<C-o>B')   -- Move back one WORD
  util.imap('<M-f>', '<C-o>W')   -- Move forward one WORD
  util.imap('<C-b>', '<C-o>b')   -- Move back one word
  util.imap('<C-f>', '<C-o>w')   -- Move forward one word
  util.imap('<M-BS>', '<C-o>dB') -- Delete back one WORD
  util.imap('<C-h>', '<C-o>db')  -- Delete back one word

  -- Command mode mapping of the same. Much more complex because command mode doesn't have
  -- <C-o> to exit command mode for one command like Insert mode does! Although this requires
  -- a lot of custom code, that made it possible to make it more closely mimic Zsh's behavior.
  vim.keymap.set('c', '<M-b>',  M.make_feedkeys_caller('cmdline_back_word   ({is_WORD = true,  is_delete = false})'))
  vim.keymap.set('c', '<M-f>',  M.make_feedkeys_caller('cmdline_forward_word({is_WORD = true,  is_delete = false})'))
  vim.keymap.set('c', '<C-b>',  M.make_feedkeys_caller('cmdline_back_word   ({is_WORD = false, is_delete = false})'))
  vim.keymap.set('c', '<C-f>',  M.make_feedkeys_caller('cmdline_forward_word({is_WORD = false, is_delete = false})'))
  vim.keymap.set('c', '<M-BS>', M.make_feedkeys_caller('cmdline_back_word   ({is_WORD = true,  is_delete = true})'))
  -- Ctrl-BS: Delete backward "word". My terminal (Gnome shell + tmux) sends <C-h> when you
  -- type <C-BS>, which is distinct from simply <BS>. Might be different on other terminals.
  vim.keymap.set('c', '<C-h>',  M.make_feedkeys_caller('cmdline_back_word   ({is_WORD = false, is_delete = true})'))

  -- Zsh-like mappings for Visual/Select mode. Less useful, but here for completeness.
  util.vmap('<M-b>', 'B')   -- Move back one WORD
  util.vmap('<M-f>', 'W')   -- Move forward one WORD
  util.vmap('<C-b>', 'b')   -- Move back one word
  util.vmap('<C-f>', 'w')   -- Move forward one word

end

return M
