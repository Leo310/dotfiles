-- LSP server config
local border = {
	{ "╭", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╮", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "╯", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "╰", "FloatBorder" },
	{ "│", "FloatBorder" },
}

-- LSP settings (for overriding per client)
vim.lsp.set_log_level('debug')
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local nvim_lsp = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.offsetEncoding = { "utf-16" } -- Because of this shit: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428


vim.notify = require('notify')
local on_attach = function(client, bufnr)
	vim.notify(string.format("[lsp] %s\n[cwd] %s", client.name, vim.fn.getcwd()), "info", { title = "[lsp] Active" }, true)

	-- Null ls takes care of it
	client.server_capabilities.document_formatting = false

	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	-- Mappings.
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap = true, silent = true }
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', '<leader>K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	--  buf_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references({ initial_mode = "normal" })<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
	buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	buf_set_keymap('n', '<leader>N', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', '<leader>n', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	buf_set_keymap('n', '<leader>gl', '<cmd>Telescope grep_string<CR>', opts)

	if client.server_capabilities.documentFormattingProvider then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format(nil, 2000)")
	end

	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=DarkMagenta guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
	end
end

-- python
require 'lspconfig'.pylsp.setup {
	cmd = { "pylsp" },
	filetypes = { "python" },
	settings = { -- for more settings: https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
		pylsp = {
			plugins = {
				jedi_completion = {
					include_params = true, -- Auto-completes methods and classes with tabstops for each parameter.
					fuzzy = true,
				},
				flake8 = {
					enabled = true,
					ignore = {},
					maxLineLength = 88
				},
				-- NOT WORKING ATM
				-- black = {
				-- 	enabled = false,
				-- maxLineLength = 79
				-- },
				pycodestyle = { enabled = false },
				isort = { enabled = false },
				yapf = { enabled = false },
				pylint = {
					enabled = true,
					args = {
						"--generated-members=torch.*",
						"--extension-pkg-whitelist=pygame",
						"--variable-rgx='[a-z0-9_]{1,30}$'",
						"--argument-rgx='[a-z0-9_]{1,30}$'",
						"--disable=C0111"
					},
				},
				rope_completion = { enabled = false }
			},
		}
	},
	capabilities = capabilities,
	root_dir = nvim_lsp.util.root_pattern("venv", "pyproject.toml", "setup.py", "setup.cfg", "Pipfile", "requirements.txt"),
	single_file_support = true,
	on_attach = on_attach,
}

-- Latex setup
require 'lspconfig'.ltex.setup {
	cmd = { 'texlab' },
	filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex" },
	settings = {
	},
	root_dir = nvim_lsp.util.root_pattern("main.tex"),
	on_attach = on_attach,
	single_file_support = true,
	capabilities = capabilities,
}

-- Spellcheck on top of native
require('spellsitter').setup {
	enable = true,
	filetypes = { "tex" },
}

-- GO setup
-- setup ray-x/go.nvim or nullls?

local with_root_file = function(builtin, file)
	return builtin.with {
		condition = function(utils)
			return utils.root_has_file(file)
		end,
	}
end
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		-- formatting
		null_ls.builtins.formatting.prettier,

		null_ls.builtins.diagnostics.eslint,
		require("typescript.extensions.null-ls.code-actions"),

	},
	on_attach = on_attach,
})

require("typescript").setup({
	disable_commands = false, -- prevent the plugin from creating Vim commands
	debug = false, -- enable debug logging for commands
	go_to_source_definition = {
		fallback = true, -- fall back to standard LSP definition on failure
	},
})

require 'lspconfig'.bashls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

-- C/C++ setup
require('lspconfig').clangd.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

-- lua
require("lspconfig").sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					-- [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},

		},
	},
})
