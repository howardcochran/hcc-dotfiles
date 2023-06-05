local harpoon = require("harpoon")

function harpoon_setup()
  harpoon.setup({
    menu = {
        width = vim.api.nvim_win_get_width(0) - 16,
    }
  })
end

harpoon_setup()
