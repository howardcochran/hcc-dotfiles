local lspsaga = require('lspsaga')
--lspsaga.setup()
lspsaga.setup({
  max_preview_lines = 40,  -- Default is a laughable 10!
  finder_action_keys = {
    -- For consistency with Telescope & nvim-tree, use their mappings For
    -- open, split, and vsplit instead of LspSaga's default of o, i, and s.
    -- Note that LspSaga does not provide a way to open in a new tab page.
    -- Also, since it allows us to specify a lsit for open, also include
    -- its dfault mapping for that.
    open = { '<CR>', 'o' },
    split = 'C-x',
    vsplit = 'C-v',
    quit = { '<Esc>', '<C-c>', 'q' },  -- LspSaga default is q, but <Esc> is more natural for me
  },
  code_action_keys = {
    close = { '<Esc>', '<C-c>', 'q' }, -- Default is q, but <esc> and <C-c> are more natural for me
    -- exec defaults to <CR>
  },
  rename_action_keys = {
    close = { '<Esc>', '<C-c>', 'q' },
    -- exec defaults to <CR>
  },

})
