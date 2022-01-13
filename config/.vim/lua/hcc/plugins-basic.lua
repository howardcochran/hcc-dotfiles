vim.cmd('colorscheme hcc')

local ok, packer = pcall(require, 'packer')
if not ok then
  print('Packer not installed. No plugins')
  return
end

local old_packer_compiled_path = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua'
if vim.fn.filereadable(old_packer_compiled_path) > 0 then
  vim.fn.delete(old_packer_compiled_path)
  error('PLEASE RESTART NVIM: A packer_compiled.nvim was found and deleted at the old path.')
  return
end

packer.init({
  -- Basic config is sometimes used where ~/.config/nvim is read-only, such as when running
  -- within a snap, so put this in ~/.local/share/nvim instead.
  compile_path = vim.fn.stdpath('data') .. '/site/plugin/packer_compiled.lua',
})

-- List of Plugins
packer.startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'tpope/vim-eunuch' }
  use { 'lambdalisue/suda.vim' }

  use { "nvim-lualine/lualine.nvim", after = "nvim-web-devicons", config = "require'hcc/plugins-config/lualine'" }

  use {
    "nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"},
    config = "require'hcc/plugins-config/telescope'"
  }

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = "require'hcc/plugins-config/gitsigns'"
  }

  -- UI Helpers
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeOopen", "NvimTreeToggle", "NvimTreeFindFile", "NvimTreeRefresh" },
    module = "nvim-tree",
    requires = "kyazdani42/nvim-web-devicons",
    config = "require'hcc/plugins-config/nvim-tree'",
  }
  use { "folke/which-key.nvim", config = "require'hcc/plugins-config/which-key'" }
  use { "ThePrimeagen/harpoon", config = "require'hcc/plugins-config/harpoon'" }
end)
