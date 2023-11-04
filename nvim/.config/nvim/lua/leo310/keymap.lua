vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted lines" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted lines" })
vim.keymap.set("n", "zz", ":w<cr>", { desc = "Better safe" })
vim.keymap.set("i", "zz", "<ESC>:w<cr>", { desc = "Better safe" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Up and center Screen" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Down and center Screen" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Search terms stay in middle" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search terms stay in middle" })
vim.keymap.set("n", "<leader>hn", ":noh<cr>", { desc = "No highlight" })
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

-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
