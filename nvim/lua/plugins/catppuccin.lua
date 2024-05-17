return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local catppuccin = require("catppuccin")
    catppuccin.setup({
      -- transparent_background = true,
      flavour = "mocha"
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
