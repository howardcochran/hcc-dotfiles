local cmp = require('cmp')
local types = require('cmp.types')
local lspkind = require('lspkind')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }), -- Start manual completion
    ['<C-y>'] = cmp.config.disable, -- Removes the default `<C-y>` mapping (which is 'confirm')
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Down>'] = cmp.mapping({i = cmp.mapping.select_next_item()}),
    ['<Up>'] = cmp.mapping({i = cmp.mapping.select_prev_item()}),
    -- - ['<Tab>'] = function(fallback)
    -- -     if require('luasnip').jumpable() then
    -- -         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
    -- -     else
    -- -         cmp.select_next_item()
    -- -     end
    -- - end,
    -- - ['<S-Tab>'] = function(fallback)
    -- -     if require('luasnip').jumpable(-1) then
    -- -         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
    -- -     else
    -- -         cmp.select_prev_item()
    -- -     end
    -- - end,
  },
  sources = {
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'buffer', keyword_length = 3 },
  },
  completion = { completeopt = 'menu,menuone,noinsert' },
  formatting = {
    format = lspkind.cmp_format({
      -- with_text = false,
      -- maxwidth = 50,
      -- before = function(entry, vim_item) return vim_item enabled
    })
  },
})

-- - -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- - cmp.setup.cmdline('/', {
-- -   sources = {
-- -     { name = 'buffer' }
-- -   }
-- - })
-- - 
-- - -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- - cmp.setup.cmdline(':', {
-- -   sources = cmp.config.sources({
-- -     { name = 'path' }
-- -   }, {
-- -     { name = 'cmdline' }
-- -   })
-- - })
-- - 
-- - -- Setup lspconfig.
-- - local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- - -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- - require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
-- -   capabilities = capabilities
-- - }
