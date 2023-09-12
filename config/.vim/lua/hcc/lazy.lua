local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- example using a list of specs with the default options
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

-- load lazy
require("lazy").setup({
  spec = { import = "hcc.plugins" },
  defaults = { lazy = true },
  install = { colorscheme = { "onedark" } },
  ui = { wrap = "true" },
  change_detection = {
    enabled = true,
    notify = false,
  },
  debug = false,
  performance = {
    rtp = {
      disabled_plugins = {
      },
    },
  },
})
