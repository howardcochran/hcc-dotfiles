local gitsigns = require('gitsigns')

require('gitsigns').setup({
  keymaps = {
    -- For consistency, use [h, ]h instead of default [c, ]c. Also simpler because we don't
    -- need the &diff conditional.
    ['n ]h'] = '<cmd>Gitsigns next_hunk<CR>',
    ['n [h'] = '<cmd>Gitsigns prev_hunk<CR>',

    ['n <leader>hB'] = '<cmd>Gitsigns toggle_current_line_blame<CR>',

    -- These are defaults, copied here because this table repaces, rather than adds to, defaults:
    ['n <leader>hs'] = '<cmd>Gitsigns stage_hunk<CR>',
    ['v <leader>hs'] = ':Gitsigns stage_hunk<CR>',
    ['n <leader>hu'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
    ['n <leader>hr'] = '<cmd>Gitsigns reset_hunk<CR>',
    ['v <leader>hr'] = ':Gitsigns reset_hunk<CR>',
    ['n <leader>hR'] = '<cmd>Gitsigns reset_buffer<CR>',
    ['n <leader>hp'] = '<cmd>Gitsigns preview_hunk<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
    ['n <leader>hS'] = '<cmd>Gitsigns stage_buffer<CR>',
    ['n <leader>hU'] = '<cmd>Gitsigns reset_buffer_index<CR>',

    ['n <leader>tb'] = '<cmd>Gitsigns toggle_current_line_blame<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
    ['x ih'] = ':<C-U>Gitsigns select_hunk<CR>'
  },
  current_line_blame_opts = {
    delay = 250,
    ignore_whitespace = true,
  },
  preview_config = {
    row = 1, -- Default is 0. Offset down one line so doesn't block view of cursor line
  },
})
