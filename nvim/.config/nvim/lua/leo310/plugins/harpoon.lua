return {
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        vim.keymap.set("n", "<leader>hm", '<cmd> lua require("harpoon.mark").add_file()<CR>', { desc = "Harpoon mark" })
        vim.keymap.set("n", "<leader>hj", '<cmd> lua require("harpoon.ui").nav_next()<CR>', { desc = "Harpoon next" })
        vim.keymap.set("n", "<leader>hf", '<cmd> lua require("harpoon.ui").nav_prev()<CR>', { desc = "Harpoon prev" })
        require("harpoon").setup({
            global_settings = {
                -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
                save_on_toggle = false,
                -- saves the harpoon file upon every change. disabling is unrecommended.
                save_on_change = true,
                -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
                enter_on_sendcmd = false,
                -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
                tmux_autoclose_windows = false,
                -- filetypes that you want to prevent from adding to the harpoon list menu.
                excluded_filetypes = { "harpoon" },
                -- set marks specific to each git branch inside git repository
                mark_branch = false,
            },
        })
    end,
}
