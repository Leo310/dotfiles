return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
        "nvim-telescope/telescope-fzy-native.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    init = function()
        -- Keymaps
        vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
        vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
        vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
        vim.keymap.set("n", "<leader>?", ":Telescope keymaps<CR>")
        vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>")
        vim.keymap.set("n", "<leader>t", ":Telescope treesitter<CR>")
        vim.keymap.set("n", "<leader>wd", ":Telescope diagnostics<CR>")
        vim.keymap.set("n", "<leader>hh", ":Telescope harpoon marks<CR>")
    end,
    config = function()
        local actions = require("telescope.actions")
        local trouble = require("trouble.providers.telescope")
        require("telescope").setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--hidden",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                prompt_prefix = "> ",
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-h>"] = actions.move_to_top,
                        ["<C-i>"] = actions.move_to_middle,
                        ["<C-l>"] = actions.move_to_bottom,
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-n>"] = actions.preview_scrolling_down,
                    },
                    n = {
                        ["<c-x>"] = trouble.open_with_trouble,
                    },
                },
                file_ignore_patterns = {
                    ".git/",
                    "node_modules",
                    "venv",
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                file_browser = {
                    hidden = true,
                },
                live_grep = {
                    hidden = true,
                },
            },
            extensions = {
                fzy_native = {
                    override_generic_sorter = false,
                    override_file_sorter = true,
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({
                        -- even more opts
                    }),
                },
            },
        })

        require("telescope").load_extension("fzy_native")
        require("telescope").load_extension("ui-select")
        require("telescope").load_extension("notify")
        require("telescope").load_extension("harpoon")
    end,
}
