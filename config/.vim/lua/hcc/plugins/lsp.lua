local M = {
  "neovim/nvim-lspconfig",
  lazy = true,
}

function M.config()

 local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  vim.diagnostic.config({
    virtual_text = true,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
      suffix = "",
    },
  })


  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}), callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      local base_opts = { buffer = bufnr, silent = true, nowait = true }
      function bufmap(mode, lhs, rhs, desc)
        local opts = base_opts
        if desc then
          opts = vim.tbl_extend('force', opts, { desc = desc })
        end
        vim.keymap.set(mode, lhs, rhs, opts)
      end
      function nbufmap(lhs, rhs, desc)
        bufmap('n', lhs, rhs, desc)
      end

      nbufmap('gD', vim.lsp.buf.declaration, 'Lsp Goto Declaration')
      nbufmap('gdd', vim.lsp.buf.definition, 'Lsp Goto Definition')
      nbufmap('gdp', '<Cmd>Lspsaga preview_definition<CR>', 'Lsp Preview Definition')
      nbufmap('grt', '<cmd>Telescope lsp_references<CR>', 'Lsp Refs Telescope')
      nbufmap('grr', '<cmd>Lspsaga lsp_finder<CR>', 'Lsp Refs Lspsaga')
      nbufmap('gi', vim.lsp.buf.implementation, 'Lsp Goto Implementation')
      nbufmap('K', '<Cmd>Lspsaga hover_doc<CR>', 'Lsp Hover')
      nbufmap('gs', '<cmd>Lspsaga signature_help<CR>', 'Lsp Signature Help')  -- Default 'C-k' conflicts with my switch windows mapping

      nbufmap('ge', '<cmd>Lspsaga show_line_diagnostics<CR>', 'Lsp Show Line Diagnostics')
      nbufmap('[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Lsp Prev Diagnostic')
      nbufmap(']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Lsp Next Diagnostic')
      nbufmap('<leader>el', '<cmd>lua vim.diagnostic.setloclist()<CR>', 'Lsp Diag LocList')
      nbufmap('<leader>eq', '<cmd>lua vim.diagnostic.setqflist()<CR>', 'Lsp Diag QuickList')

      nbufmap('<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
      nbufmap('<leader>rn', '<cmd>Lspsaga rename<CR>', 'Lsp Rename')
      nbufmap('<leader>ca', '<cmd>Lspsaga code_action<CR>', 'Lsp Code Action')
      bufmap('v', '<leader>ca', '<cmd>Lspsaga range_code_action<CR>', 'Lsp Range Code Action')
      nbufmap('<space>f', function() vim.lsp.buf.format { async = true } end, 'Lsp Format Buffer')
      nbufmap('<leader>te', '<cmd>lua require("hcc/plugins-config/lspconfig").ToggleDiagnosticVirtualText()<CR>')
    end,
  })

--  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--    border = "rounded",
--  })
--
--  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--    border = "rounded",
--  })
end

return M
