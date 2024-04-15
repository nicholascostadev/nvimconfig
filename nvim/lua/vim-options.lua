vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-- vim.opt.guicursor = ""
vim.g.mapleader = " "
vim.wo.relativenumber = true
vim.diagnostic.config({
  update_in_insert = true,
})
vim.opt.scrolloff = 10
vim.opt.cursorline = true
