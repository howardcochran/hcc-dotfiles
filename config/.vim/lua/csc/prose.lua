-- In Prose mode, parenthesis and curly bracket movements are helpful for
-- moving between sentences and paragraphs, respectively.

function Prose()
  -- Enable concealing of markdown tags (*, etc.)
  vim.opt_local.conceallevel = 3
  -- Only unconceal the current line in insert mode
  vim.opt_local.concealcursor = 'n'

  -- Auto-format current paragraph when typing.
  vim.opt_local.formatoptions:append('a')

  -- Set undo markers at punctation (helpful when writing a lot of prose in
  -- insert mode at once)
  vim.keymap.set('i', '.', '.<c-g>u', { noremap=true, buffer=true })
  vim.keymap.set('i', '!', '!<c-g>u', { noremap=true, buffer=true })
  vim.keymap.set('i', '?', '?<c-g>u', { noremap=true, buffer=true })
  vim.keymap.set('i', ',', ',<c-g>u', { noremap=true, buffer=true })
  vim.keymap.set('i', ';', ';<c-g>u', { noremap=true, buffer=true })
  vim.keymap.set('i', ':', ':<c-g>u', { noremap=true, buffer=true })
end

function ProseOff()
  vim.opt_local.conceallevel = 0
  vim.opt_local.concealcursor = ''
  vim.opt_local.formatoptions:remove('a')
  vim.keymap.del('i', '.', { buffer=true })
  vim.keymap.del('i', '!', { buffer=true })
  vim.keymap.del('i', '?', { buffer=true })
  vim.keymap.del('i', ',', { buffer=true })
  vim.keymap.del('i', ';', { buffer=true })
  vim.keymap.del('i', ':', { buffer=true })
end

-- Enable toggling of Prose mode via a nvim command
vim.api.nvim_create_user_command('Prose', Prose, {})
vim.api.nvim_create_user_command('ProseOff', ProseOff, {})

-- Automatically enter Prose mode in markdown files
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { '*.md', '*.markdown', '*.mkd' },
  command = 'Prose',
})
