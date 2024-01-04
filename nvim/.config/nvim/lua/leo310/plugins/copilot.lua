return {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    dependencies = {
        -- "zbirenbaum/copilot-cmp",
    },
    config = function()
        require("copilot").setup({
            panel = {
                enabled = false,
            },
            suggestion = {
                auto_trigger = true,
                enabled = true,
                keymap = {
                    accept = "<leader>L",
                    accept_word = false,
                    accept_line = false,
                    next = "<leader>J",
                    -- prev = "<leader>K",
                    dismiss = "<leader>H",
                },
            },
        })
        -- require("copilot_cmp").setup()
    end,
}
