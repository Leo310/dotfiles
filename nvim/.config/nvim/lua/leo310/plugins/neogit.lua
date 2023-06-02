return {
    "TimUntersberger/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.keymap.set("n", "<leader>gs", ":Neogit<CR>", { desc = "Opens neogit" })
        require("neogit").setup({
            integrations = {
                diffview = true,
            },
        })
    end,
}
