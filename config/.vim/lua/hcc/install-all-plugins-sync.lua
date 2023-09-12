-- Define a user function, InstallAllPluginsSync, that will synchronously
-- do the initial installation or updating of all plugins that we use
-- (Lazy, TreeSitter, and LSPs via mason-lspconfig).
-- It is intended to be used headless, for example, from a dotfiles
-- install script, like this:
--
-- nvim --headless -c InstallAllPluginsSync -c qa
--
-- Essentially, this is a workaround for the fact that mason-lspconfig
-- does not provide any way to know when its "ensure_installed" list of
-- plugins is finished installing.

function install_all_plugins_sync()
  require("lazy").sync{wait = true}  -- Equivalent to vim.cmd('Lazy! sync')

  -- WARNING: Testing has shown that this is not really synchronous. It seems to wait
  -- until about half of the parsers are installed. Maybe it's just waiting until
  -- they're all downloaded but not until they're finished compiling. Calling it
  -- a second time doesn't help (returns immediately).
  -- So this whole thing is still racy.  Sigh.
  vim.cmd('TSUpdateSync')

  -- Unfortunately, we have to slightly reach into the guts of mason-lspconfig because it
  -- explicitly won't install the things on its ensure_installed list in headless mode
  -- Furthermore, when in interactive mode, it does so asynchronously, providing no
  -- way to know when it is done. But its LspInstall user command is synchronous, so
  -- we reach into its settings to retrieve the ensure_installed list and call that.
  lsp_to_install = require("mason-lspconfig.settings").current.ensure_installed
  lsp_to_install_str = table.concat(lsp_to_install, " ")
  print("Installing these LSPs via mason-lspconfig: " .. lsp_to_install_str)
  vim.cmd('LspInstall ' .. lsp_to_install_str)
end

vim.api.nvim_create_user_command('InstallAllPluginsSync', install_all_plugins_sync, {
  desc = 'Install (or update) all Lazy plugins, Mason LSPs, and TreeSitter plugins synchronously.',
})
    -- MasonInstall bashls clangd cssls dockerls dotls html jsonls neocmake pyright yamlls
