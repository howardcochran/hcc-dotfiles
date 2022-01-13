-- Make it real obvious when we're in Insert mode by changing background
-- Would rather this be local to current window only, but there
-- doesn't seem to be a way to control the definition of the Normal highlight
-- on a per-window basis. I would also prefer the background to be a very
-- dark red, but the darkest possile is still too bright.
vim.cmd([[
augroup ToggleBackgroundInInsertMode
    au!
    au InsertEnter * :highlight Normal guibg=#100000 ctermbg=16
    au InsertLeave * :highlight Normal guibg=#000038 ctermbg=17
augroup END
]])
