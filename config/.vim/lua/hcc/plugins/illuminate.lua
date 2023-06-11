local M = {
  "RRethy/vim-illuminate",
  event = "VeryLazy",
  config = function()
    require "illuminate".configure({
      delay = 200,
      -- Pretty extensive list of exclusions, even though I don't currently use all of these plugins
      -- Taken from: https://github.com/LunarVim/nvim-basic-ide/blob/master/lua/user/illuminate.lua
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "alpha",
        "NvimTree",
        "packer",
        "neogitstatus",
        "Trouble",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
      },
    })
  end
}

return M
