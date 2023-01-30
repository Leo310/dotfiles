return {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    dependencies = {
        "zbirenbaum/copilot-cmp",
    },
    config = function()
        require("copilot").setup({
            panel = {
                enable = false,
            },
            suggestion = {
                enable = false,
            },
        })
        require("copilot_cmp").setup()
    end
}
