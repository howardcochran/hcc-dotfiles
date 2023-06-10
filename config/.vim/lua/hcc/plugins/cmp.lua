local M = {
  "hrsh7th/nvim-cmp",
  version = false,
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "onsails/lspkind-nvim",
    "rafamadriz/friendly-snippets",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
}

function M.config()
  local cmp = require('cmp')
  -- local types = require('cmp.types')
  local lspkind = require('lspkind')
  local luasnip = require('luasnip')

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }), -- Start manual completion
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<Esc>'] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() then
            cmp.abort()
          else
            fallback()
          end
        end,
        c = function(fallback)
          if cmp.visible() then
            cmp.close()
          else
            fallback()
          end
        end,
      }),
      ['<Up>'] = cmp.mapping({i = cmp.mapping.select_prev_item()}),
      -- Special function needed to keep <Down> from skipping first entry when no selection yet.
      ['<Down>'] = cmp.mapping(
        function(callback)
          if cmp.get_active_entry() then
            cmp.select_next_item()
          else
            cmp.select_next_item({count = 0})
          end
        end,
        { 'i', 'c', 's' }
      ),
      ['<CR>'] = cmp.mapping({
        -- Only complete the item if explicitly selected (typ. via <Down> or <Tab>)
        -- otherwise fallback to inserting a newline (canceling the menu in process.
        -- This is really important to prevent last word on a line from being replaced
        -- by the first completion item, making typing prose very hard!
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      }),
      ['<Tab>'] = cmp.mapping(
        function(fallback)
          if cmp.visible() then
            -- Keep Tab from skpping 1st entry when no selection yet.
            if cmp.get_active_entry() then
              cmp.select_next_item()
            else
              cmp.select_next_item({count = 0})
            end
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          --elseif has_words_before() then
            --cmp.complete()
          else
            fallback()
          end
        end,
        { 'i', 's' }
      ),
      ['<S-Tab>'] = cmp.mapping(
        function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end,
        { 'i', 's' }
      ),
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
end

return M

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
