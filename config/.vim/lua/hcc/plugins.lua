-- Bootstrap Packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Wrapper function to load config from separate file by specifying:
-- ext = load "filename"
-- local use = function(config)
--     if config.ext then
--         config = vim.tbl_deep_extend("force", config, config.ext)
--         config.ext = nil
--     end
--     packer.use(config)
-- end
--
-- local load = function(path)
--     local ok, res = pcall(require, "hcc/plugins-config/" .. path)
--     if ok then
--         return res
--     else
--         vim.notify("Could not load " .. path)
--         return {}
--     end
-- end

-- List of Plugins
require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'tpope/vim-eunuch' }
--   -- OLD: use 'scrooloose/nerdcommenter'
--   use { 'wesQ3/vim-windowswap' }
--   -- OLD: use 'junegunn/fzf.vim'
--   -- OLD: use 'neoclide/coc.nvim', {'branch': 'release'}
--   use { 'vim-airline/vim-airline' }
--   use { 'preservim/nerdtree' }
--   use { 'Xuyuanp/nerdtree-git-plugin' }
--   use { 'joshdick/onedark.vim' }   -- Color scheme
--   use { 'liuchengxu/vista.vim' }
  use { 'lambdalisue/suda.vim' }
-- 
--   use { "nvim-lua/plenary.nvim" }
--   use { "nvim-lua/popup.nvim" }
-- 
--   -- Theme
--  use { 'tiagovla/tokyodark.nvim' }
  -- use { 'joshdick/onedark.nvim' }  TODO: Not working. At least not registering as a colorscheme properly.
  use { "olimorris/onedarkpro.nvim", config = "require'hcc/plugins-config/onedark'" }
  use { "kyazdani42/nvim-web-devicons", after = "onedarkpro.nvim" }
  use { "nvim-lualine/lualine.nvim", after = "nvim-web-devicons", config = "require'hcc/plugins-config/lualine'" }
--   use { "akinsho/nvim-bufferline.lua", after = "nvim-web-devicons", ext = load "bufferline" }

  use {
    "nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"},
    config = "require'hcc/plugins-config/telescope'"
    -- cmd = "Telescope",
    -- module = 'telescope',
  }
  -- NOTYET: use { "nvim-telescope/telescope-media-files.nvim", after = "telescope.nvim" }
  -- NOTYET: use { "nvim-telescope/telescope-project.nvim", ext = load "project", after = "telescope.nvim" }
  -- WHAT'S THIS? use { "$HOME/github/session-lens", after = "telescope.nvim" }

--   -- Syntax
   use { "nvim-treesitter/nvim-treesitter", event = "BufEnter", after = "nvim-tree.lua", config = "require'hcc/plugins-config/treesitter'" }
   use { "nvim-treesitter/playground", after = "nvim-treesitter" }
-- 
--   -- Lsp
  use { "neovim/nvim-lspconfig", config = "require'hcc/plugins-config/lspconfig'", opt = false, }
  -- The following is a maintained fork of glepnir/lspsga.nvim, which has had
  -- no commits since Apr 2021
  use { "tami5/lspsaga.nvim", config = "require'hcc/plugins-config/lspsaga'", opt = false, }
--  use {
--    "tiagovla/lspconfigplus",
--    requires = {"neovim/nvim-lspconfig", opt = false},
--    config = "require'hcc/plugins-config/lsp'",
--    event = "BufReadPre"
--  }
  -- NOTYET: use { "ray-x/lsp_signature.nvim", after = "lspconfigplus" }
-- 
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
  use { "rafamadriz/friendly-snippets", event = "InsertEnter" }
  use { "hrsh7th/nvim-cmp", config = "require'hcc/plugins-config/cmp'", after = "friendly-snippets" }
  use { "L3MON4D3/LuaSnip", wants = "friendly-snippets", after = "nvim-cmp", module = "luasnip" }
  use { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }
  use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }    -- TODO: Maybe add Locality bonus comparitor (README)
  use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", opt = false }
  use { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }
  use { "hrsh7th/cmp-path", after = "nvim-cmp" }
  use { "onsails/lspkind-nvim", after = "nvim-cmp", opt = false }
-- 
--   -- UI Helpers
  use {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeOopen", "NvimTreeToggle", "NvimTreeFindFile", "NvimTreeRefresh" },
    module = "nvim-tree",
    requires = "kyazdani42/nvim-web-devicons",
    config = "require'hcc/plugins-config/nvim-tree'",
  }
--   -- NOPE: use { "christoomey/vim-tmux-navigator", ext = load "vim_tmux_navigator" }
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

vim.cmd("packadd lspkind-nvim")  -- Don't really know why this has to be done manually
