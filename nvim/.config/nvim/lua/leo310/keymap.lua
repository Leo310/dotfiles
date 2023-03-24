vim.g.mapleader = " "
vim.g.maplocalleader = " " -- filetype specifc leader key
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted lines" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted lines" })
vim.keymap.set("n", "zz", ":w<cr>", { desc = "Better safe" })
vim.keymap.set("i", "zz", "<ESC>:w<cr>", { desc = "Better safe" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Up and center Screen" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Down and center Screen" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Search terms stay in middle" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search terms stay in middle" })
-- vim.keymap.set("n", "<leader>h", ":noh<cr>", { desc = "No highlight" })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "What does this do?" })
vim.keymap.set("x", "<leader>p", '"_dp', { desc = "greatest remap ever" })
vim.keymap.set("x", "<leader>P", '"_dP', { desc = "greatest remap ever" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "deleting to void register" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "to system clipboard" })
vim.keymap.set(
    "n",
    "<leader>s",
    ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "Better substitution" }
)
vim.keymap.set("i", "<C-c>", "<Esc>")
