return {
    {
        "glepnir/dashboard-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VimEnter",
        config = function()
            vim.keymap.set("n", "<leader>dd", ":Dashboard<CR>", { desc = "Open Dashboard" })
            math.randomseed(os.time())
            local randomNumber = math.random(4)
            local speed = "1.0"
            if randomNumber == 1 then
                speed = "0.4"
            elseif randomNumber == 2 then
                speed = "0.6"
            end
            require("dashboard").setup({
                theme = "doom",
                preview = {
                    file_height = 20,
                    file_width = 40,
                    file_path = "~/.config/nvim/db/head" .. randomNumber .. ".gif",
                    command = "chafa -c full --fg-only --speed " .. speed .. " --symbols braille",
                },
                config = {
                    center = {
                        { icon = "  ", desc = "Find file              ", action = "Telescope find_files" },
                        { icon = "  ", desc = "Recently latest session", action = "SessionLoad" },
                        {
                            icon = "  ",
                            desc = "My Projects            ",
                            action = "!tmux neww ~/.tmux/sessionizer.sh",
                        },
                        { icon = "  ", desc = "New file               ", action = "enew" },
                        -- padding
                        { icon = " ", desc = " ", action = "" },
                        -- { icon = '  ', desc = 'Recently Used Files    ', action = 'Telescope oldfiles' }
                    },
                    footer = { "🪩 To the moon!!! 🚀" },
                },
            })
        end,
    },
    {
        "glepnir/dbsession.nvim",
        cmd = { "SessionSave", "SessionDelete", "SessionLoad" },
        opts = {
            auto_save_on_exit = true,
        },
    },
}
