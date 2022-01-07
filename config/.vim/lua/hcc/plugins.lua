-- Bootstrap Packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print('Installing packer.')
  packer_bootstrap = vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd('packadd packer.nvim')
end

-- List of Plugins
require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'tpope/vim-eunuch' }
  use { 'lambdalisue/suda.vim' }

  use { "olimorris/onedarkpro.nvim", config = "require'hcc/plugins-config/onedark'" }
  use { "kyazdani42/nvim-web-devicons", after = "onedarkpro.nvim" }
  use { "nvim-lualine/lualine.nvim", after = "nvim-web-devicons", config = "require'hcc/plugins-config/lualine'" }

  use {
    "nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"},
    config = "require'hcc/plugins-config/telescope'"
  }
  -- NOTYET: use { "nvim-telescope/telescope-media-files.nvim", after = "telescope.nvim" }
  -- NOTYET: use { "nvim-telescope/telescope-project.nvim", ext = load "project", after = "telescope.nvim" }
  -- WHAT'S THIS? use { "$HOME/github/session-lens", after = "telescope.nvim" }

--   -- Syntax
  use { "nvim-treesitter/nvim-treesitter", event = "BufEnter", after = "nvim-tree.lua", config = "require'hcc/plugins-config/treesitter'" }
  use { "nvim-treesitter/playground", after = "nvim-treesitter" }

--   -- Lsp
  use { "neovim/nvim-lspconfig", config = "require'hcc/plugins-config/lspconfig'", opt = false, }
  -- The following is a maintained fork of glepnir/lspsga.nvim, which has had
  -- no commits since Apr 2021
  use { "tami5/lspsaga.nvim", config = "require'hcc/plugins-config/lspsaga'", opt = false, }
  -- NOTYET: use { "ray-x/lsp_signature.nvim", after = "lspconfigplus" }

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = "require'hcc/plugins-config/gitsigns'"
  }
  -- NOTYET use { "TimUntersberger/neogit", ext = load "neogit", cmd = { "Neogit" } }

  -- Auto-complete
  -- NOTE: I don't actually use Snippits, but some kind of snippit handler
  -- must be present for nvim-cmp to work.
  use { "onsails/lspkind-nvim", opt = false }
  use { "rafamadriz/friendly-snippets", event = "InsertEnter" }
  use { "hrsh7th/nvim-cmp", config = "require'hcc/plugins-config/cmp'", after = {"friendly-snippets", "lspkind-nvim"} }
  use { "L3MON4D3/LuaSnip", wants = "friendly-snippets", after = "nvim-cmp", module = "luasnip" }
  use { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }
  use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }    -- TODO: Maybe add Locality bonus comparitor (README)
  use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", opt = false }
  use { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }
  use { "hrsh7th/cmp-path", after = "nvim-cmp" }
--
--   -- UI Helpers
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeOopen", "NvimTreeToggle", "NvimTreeFindFile", "NvimTreeRefresh" },
    module = "nvim-tree",
    requires = "kyazdani42/nvim-web-devicons",
    config = "require'hcc/plugins-config/nvim-tree'",
  }
--   -- NOTYET: use { "luukvbaal/stabilize.nvim", event = "BufRead", ext = load "stabilize" }
--   -- NOTYET: use { "akinsho/toggleterm.nvim", ext = load "toggleterm", cmd = "ToggleTerm" }
--   -- NOTYET: use { "folke/trouble.nvim", cmd = { "Trouble" }, ext = load "trouble", module = "trouble" }
  use { "folke/which-key.nvim", config = "require'hcc/plugins-config/which-key'" }
  use { "ThePrimeagen/harpoon", config = "require'hcc/plugins-config/harpoon'" }
--
--   -- Commenter & Colorizer
--   -- NOTYET: use { "norcalli/nvim-colorizer.lua", event = "BufRead", ext = load "colorizer" }
--   use { "tpope/vim-commentary", event = "BufRead" }
--
--   -- Documents
--   -- NOPE: use { "tiagovla/tex-conceal.vim", ft = "tex" }
--   use { "iamcco/markdown-preview.nvim", ext = load "markdownpreview" }
--   -- NOTYET: use { "kkoomen/vim-doge", ext = load "vimdoge" }
--
--   -- Debug
--   use { "mfussenegger/nvim-dap", ext = load "dap", module = "dap" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
