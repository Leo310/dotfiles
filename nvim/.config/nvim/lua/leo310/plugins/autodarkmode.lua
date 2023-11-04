return {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    config = {
        update_interval = 1000,
        set_dark_mode = function()
            vim.api.nvim_set_option("background", "dark")
            vim.cmd("colorscheme dracula")
        end,
        set_light_mode = function()
            vim.api.nvim_set_option("background", "light")
            vim.g.edge_transparent_background = 0
            vim.g.edge_disable_italic_comment = 1
            vim.cmd("colorscheme edge")
            -- vim.cmd("colorscheme dracula")
        end,
    },
}
