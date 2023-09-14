local M = {
  'lewis6991/gitsigns.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  event = 'BufReadPre',
}

function M.config()
  require('gitsigns').setup({
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      local function my_next_hunk()
        if vim.wo.diff then return ']c' end
        vim.schedule(gs.next_hunk)
        return '<Ignore>'
      end
      local function my_prev_hunk()
        if vim.wo.diff then return '[c' end
        vim.schedule(gs.prev_hunk)
        return '<Ignore>'
      end

      -- Map to both ]h and ]c because used ]h in the past, but most people expect ]c
      map('n', ']h', my_next_hunk, {expr=true})
      map('n', '[h', my_prev_hunk, {expr=true})
      map('n', ']c', my_next_hunk, {expr=true})
      map('n', '[c', my_prev_hunk, {expr=true})

      -- Suggestions from gitsigns author:
      map('n', '<leader>hs', gs.stage_hunk)
      map('n', '<leader>hr', gs.reset_hunk)
      map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      map('n', '<leader>hS', gs.stage_buffer)
      map('n', '<leader>hu', gs.undo_stage_hunk)
      map('n', '<leader>hR', gs.reset_buffer)
      map('n', '<leader>hp', gs.preview_hunk)
      map('n', '<leader>hb', function() gs.blame_line{full=true} end)
      map('n', '<leader>tb', gs.toggle_current_line_blame)
      map('n', '<leader>hd', gs.diffthis)
      map('n', '<leader>hD', function() gs.diffthis('~') end)
      map('n', '<leader>td', gs.toggle_deleted)

      -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      map({'o', 'x'}, 'ih', gs.select_hunk)
    end,

    current_line_blame_opts = {
      delay = 250,
      ignore_whitespace = true,
    },
    preview_config = {
      row = 1, -- Default is 0. Offset down one line so doesn't block view of cursor line
    },
  })
end

return M
