vim.g.mapleader = " "
vim.keymap.set("n", "zz", ":w<cr>", { desc = 'Better safe' })
vim.keymap.set("i", "zz", "<ESC>:w<cr>", { desc = 'Better safe' })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Up and center Screen' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Down and center Screen' })
vim.keymap.set("n", "<leader>h", ":noh<cr>", { desc = 'No highlight' })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'What does this do?' })
vim.keymap.set("x", "<leader>p", "\"_dp", { desc = 'greatest remap ever' })
vim.keymap.set("x", "<leader>P", "\"_dP", { desc = 'greatest remap ever' })
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = 'Better substitution' })
