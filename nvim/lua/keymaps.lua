vim.keymap.set("n", "<C-l>", "<C-w>l", {})
vim.keymap.set("n", "<C-k>", "<C-w>k", {})
vim.keymap.set("n", "<C-j>", "<C-w>j", {})
vim.keymap.set("n", "<C-h>", "<C-w>h", {})
vim.keymap.set("n", "<leader>ch", ":noh<CR>", {})

vim.keymap.set("n", "<leader>ba", ":%bd|e#<CR>", {})
vim.keymap.set("n", "<leader>bc", ":%bd<CR>", {})

vim.api.nvim_set_option("clipboard", "unnamed")
