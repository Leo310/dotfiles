-- LSP server config
local border = {
      {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"},
}

-- LSP settings (for overriding per client)
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local nvim_lsp = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.notify = require('notify')
local on_attach = function(client, bufnr)
  vim.notify(string.format("[lsp] %s\n[cwd] %s", client.name, vim.fn.getcwd()), "info", { title = "[lsp] Active" }, true)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
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
  buf_set_keymap('n', 'gR', '<cmd>GoRename<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<leader>N', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<leader>n', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>gl', '<cmd>Telescope grep_string<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 2000)")
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
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
require'lspconfig'.pylsp.setup{
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
					enabled = false,
					-- "exclude": [],
					-- "hangClosing": false,
					-- ignore = {"E501"},
					maxLineLength = 100,
					-- indentSize = 245,
					-- "perFileIgnores": [],
					-- "select": []
				},
				pycodestyle = {
					maxLineLength = 100,
				}
			},
		}
	},
	capabilities = capabilities,
	root_dir = nvim_lsp.util.root_pattern("venv", "pyproject.toml", "setup.py", "setup.cfg", "Pipfile", "requirements.txt"),
	single_file_support = true,
	on_attach = on_attach,
}

-- Latex setup
require'lspconfig'.ltex.setup{
	cmd = {'texlab'},
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
	filetypes = {"tex"},
}

-- Java setup
-- require'lspconfig'.jdtls.setup{
-- 	cmd = {"jdtls"},
-- 	filetypes = {"java"},
-- 	on_attach = on_attach,
-- 	single_file_support = true,
-- 	root_dir = nvim_lsp.util.root_pattern(".git"),
-- }
--

-- GO setup
nvim_lsp.gopls.setup{
	cmd = {'gopls'},
	-- for postfix snippets and analyzers
	capabilities = capabilities,
	settings = {
		gopls = {
			experimentalPostfixCompletions = true,
			analyses = {
				unusedparams = true,
				shadow = true,
		 },
		 staticcheck = true,
		},
	},
	on_attach = on_attach,
}

function goimports(timeoutms)
	local context = { source = { organizeImports = true } }
	vim.validate { context = { context, "t", true } }

	local params = vim.lsp.util.make_range_params()
	params.context = context

	-- See the implementation of the textDocument/codeAction callback
	-- (lua/vim/lsp/handler.lua) for how to do this properly.
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
	if not result or next(result) == nil then return end
	local actions = result[1].result
	if not actions then return end
	local action = actions[1]

	-- textDocument/codeAction can return either Command[] or CodeAction[]. If it
	-- is a CodeAction, it can have either an edit, a command or both. Edits
	-- should be executed first.
	if action.edit or type(action.command) == "table" then
	  if action.edit then
		vim.lsp.util.applyworkspace_edit(action.edit)
	  end
	  if type(action.command) == "table" then
		vim.lsp.buf.execute_command(action.command)
	  end
	else
	  vim.lsp.buf.execute_command(action)
	end
end

--vim.lsp.set_log_level("debug")_

-- Typescript
nvim_lsp.tsserver.setup({
		capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)
        on_attach(client, bufnr)
  		local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  		local opts = { noremap=true, silent=true }
  		buf_set_keymap('n', "gt", ":TSLspOrganize<CR>", opts)
  		buf_set_keymap('n', "go", ":TSLspImportAll<CR>", opts)
  		buf_set_keymap('n', "gi", ":TSLspRenameFile<CR>", opts)
    end,
})

require'lspconfig'.bashls.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}
