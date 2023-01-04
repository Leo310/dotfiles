return {
	"williamboman/mason.nvim",
	dependencies = {
		'williamboman/mason-lspconfig'
	},
	config = function()
		require('mason-lspconfig').setup({
			ensure_installed = {
				'sumneko_lua',
				'tsserver',
				'clangd',
			}
		})
		require("mason").setup({
			-- The directory in which to install packages.
			log_level = vim.log.levels.INFO,
			max_concurrent_installers = 4,
			ui = {
				-- Whether to automatically check for new versions when opening the :Mason window.
				check_outdated_packages_on_open = true,
				border = {
					{ "╭", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╮", "FloatBorder" },
					{ "│", "FloatBorder" },
					{ "╯", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╰", "FloatBorder" },
					{ "│", "FloatBorder" },
				},

				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				keymaps = {
					toggle_package_expand = "<CR>",
					install_package = "i",
					update_package = "u",
					check_package_version = "c",
					update_all_packages = "U",
					check_outdated_packages = "C",
					uninstall_package = "X",
					cancel_installation = "<C-c>",
					apply_language_filter = "<C-f>",
				},
			},
		})
	end
}
