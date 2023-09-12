local M = {
  'williamboman/mason.nvim',
  cmd = 'Mason',

  -- Need non-lazy to make this work: nvim --headless -c InstallAllPlginsSync -c qa
  -- See ~/.config/nvim/lua/install-all-plugins-sync.lua
  lazy = false,
  -- event = 'BufReadPre',

  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    'tami5/lspsaga.nvim',
    'onsails/lspkind-nvim',
  },
}


local common_capabilities = vim.lsp.protocol.make_client_capabilities()
common_capabilities.textDocument.completion.completionItem.snippetSupport = true
common_capabilities = require('cmp_nvim_lsp').default_capabilities(M.capabilities)

function my_handler(server_name, opts)
  merged_opts = vim.tbl_extend('keep', opts, {
    capabilities = common_capabilities,
  })
  require('lspconfig')[server_name].setup(merged_opts)
end

function M.config()
  require('mason').setup({
    ui = {
      border = 'rounded',
      check_outdated_packages_on_open = true,
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 8,
  })

  require('mason-lspconfig').setup {
    ensure_installed = {
      'bashls',
      'clangd',
      'cssls',
      'dockerls',
      'dotls',
      --'rust_analyzer',  # Not Yet
      'html',
      'jqls',
      'jsonls',
      -- 'ltex',      -- LaTeX: Too big to turn on by default for now (>230MiB)
      'lua_ls',
      'marksman',  -- Markdown
      'neocmake',
      'pyright',
      -- 'salt_ls', Fails install: /home/bar/.local/share/nvim/mason/packages/salt-lsp/venv/bin/python failed with exit code 1 and signal 0
      'sqlls',
      'yamlls',    -- TODO: Add some schema support, .sls ft, etc
    },
    automatic_installation = true,

    handlers = {
      -- default handler:
      function (server_name)
        my_handler(server_name, {})
      end,

      ['bashls'] = function()
        my_handler('bashls', {
          filetypes = { 'sh', 'zsh' },  -- Added 'zsh' here. This gets it working.
          -- Added .zsh to default GLOB_PATTERN. Not sure wht this is for.
          cmd_env = { GLOB_PATTERN = '*@(.sh|.inc|.bash|.command|.zsh)' }
        })
      end,

      ['clangd'] = function()
        my_handler('clangd', {
          cmd = { 'clangd', '--background-index' }
        })
      end,
    },
  }
end

return M
