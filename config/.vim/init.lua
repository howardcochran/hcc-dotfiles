require('hcc/options')
if vim.env['NVIM_BASIC_CONFIG'] then
  require('hcc/plugins-basic')
else
  require('hcc/lazy')
end
require('hcc/mappings')
require('hcc/highlight-trailing-whitespace')
require('hcc/toggle-background-in-insert-mode')
require('hcc/shell-like-mappings').setup()
require('hcc/install-all-plugins-sync')

require('csc/prose')

-- DiffOrig: Diff file with on-disk version
-- TODO: Rewrite in Lua?  Do it better?
vim.cmd([[
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
]])

-- Filter current buffer to a new temporary buffer (i.e current buffer grep)
vim.cmd([[
command! -nargs=0 Filter let @f='' | execute 'g//y F' | new | setlocal bt=nofile | put! f
]])

-- Same thing, but invert the filter, selecting lines that do NOT match
vim.cmd([[
command! -nargs=0 FilterV let @f='' | execute 'v//y F' | new | setlocal bt=nofile | put! f
]])
