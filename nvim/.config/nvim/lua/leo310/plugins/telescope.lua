return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		'nvim-telescope/telescope-fzy-native.nvim',
		'nvim-telescope/telescope-ui-select.nvim',
		'nvim-telescope/telescope-project.nvim',
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
		vim.keymap.set("n", "<leader>ws", ":Telescope project<CR>")

	end,
	config = function()
		local actions = require("telescope.actions")
		local trouble = require("trouble.providers.telescope")
		require('telescope').setup({
			defaults = {
				-- Default configuration for telescope goes here:
				-- config_key = value,
				-- ..
				vimgrep_arguments = { 'rg', '--hidden', '--color=never', '--no-heading', '--with-filename', '--line-number',
					'--column',
					'--smart-case' },
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
					".git",
					"node_modules",
					"venv"
				}
			},
			pickers = {
				find_files = {
					hidden = true
				},
				file_browser = {
					hidden = true
				},
				live_grep = {
					hidden = true
				},
			},
			extensions = {
				fzy_native = {
					override_generic_sorter = false,
					override_file_sorter = true
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown {
						-- even more opts
					}
				},
				project = {
					hidden_files = true, -- default: false
					theme = "dropdown",
					display_type = 'full'
				}
			},
		})

		require('telescope').load_extension('fzy_native')
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("project")
		require("telescope").load_extension("notify")
	end
}
