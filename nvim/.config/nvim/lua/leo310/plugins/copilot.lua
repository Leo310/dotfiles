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
                    accept = "<M-L>",
                    accept_word = false,
                    accept_line = false,
                    next = "<M-J>",
                    prev = "<M-K>",
                    dismiss = "<M-H>",
                },
            },
        })
        -- require("copilot_cmp").setup()
    end
}
