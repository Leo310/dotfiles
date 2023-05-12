return {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
        -- null ls
        "jose-elias-alvarez/typescript.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        -- Typescript setup
        "jose-elias-alvarez/nvim-lsp-ts-utils",
        -- Java setup
        "mfussenegger/nvim-jdtls",
        -- Latex
        "lervag/vimtex",
        "lewis6991/spellsitter.nvim",
        -- Go
        "ray-x/go.nvim",
        "folke/neodev.nvim",
    },
    config = function()
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
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or border
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        -- Border around LSPInfo
        require("lspconfig.ui.windows").default_options = {
            border = border,
        }
        -- LSP server config
        local nvim_lsp = require("lspconfig")
        -- vim.lsp.set_log_level("info")

        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        -- capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.offsetEncoding = { "utf-16" } -- Because of this shit: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428

        vim.notify = require("notify")
        local function format(buf)
            local ft = vim.bo[buf].filetype
            local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0
            vim.lsp.buf.format({
                filter = function(client)
                    -- apply whatever logic you want (in this example, we'll only use null-ls)
                    if have_nls then
                        return client.name == "null-ls"
                    end
                    return client.name ~= "null-ls"
                end,
                bufnr = buf,
                timeout_ms = 2000,
            })
        end

        local on_attach = function(client, bufnr)
            vim.notify(
                string.format("[lsp] %s\n[cwd] %s", client.name, vim.fn.getcwd()),
                "info",
                { title = "[lsp] Active" },
                true
            )

            -- Null ls takes care of it
            client.server_capabilities.document_formatting = false

            local function buf_set_keymap(...)
                vim.api.nvim_buf_set_keymap(bufnr, ...)
            end

            local function buf_set_option(...)
                vim.api.nvim_buf_set_option(bufnr, ...)
            end

            -- Mappings.
            buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

            local opts = { noremap = true, silent = true }
            buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
            buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
            buf_set_keymap("n", "ga", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts)
            buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
            buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
            buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
            buf_set_keymap(
                "n",
                "<leader>wl",
                "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
                opts
            )
            buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
            buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
            --  buf_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references({ initial_mode = "normal" })<CR>', opts)
            buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
            buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
            buf_set_keymap("n", "<leader>N", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
            buf_set_keymap("n", "<leader>n", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
            buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
            buf_set_keymap("n", "<leader>gl", "<cmd>Telescope grep_string<CR>", opts)

            vim.cmd([[
                autocmd BufRead,BufNewFile *.env lua vim.diagnostic.disable()
                autocmd BufRead,BufNewFile .env lua vim.diagnostic.disable()
            ]])
            -- Format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
                buffer = bufnr,
                callback = function()
                    format(bufnr)
                end,
            })
            -- Set autocommands conditional on server_capabilities
            if client.server_capabilities.documentHighlightProvider then
                vim.api.nvim_exec(
                    [[
				  augroup lsp_document_highlight
					autocmd! * <buffer>
					autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
					autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
				  augroup END
				]],
                    false
                )
            end
        end

        -- Spellcheck on top of native
        require("spellsitter").setup({
            enable = true,
            filetypes = { "tex" },
        })

        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- formatting
                null_ls.builtins.formatting.prettier,
                -- null_ls.builtins.diagnostics.eslint,
                null_ls.builtins.formatting.latexindent,
                null_ls.builtins.diagnostics.cpplint,
                null_ls.builtins.formatting.clang_format,

                -- null_ls.builtins.diagnostics.solhint,

                null_ls.builtins.formatting.black,
                null_ls.builtins.diagnostics.ruff,

                null_ls.builtins.code_actions.gitsigns,
                null_ls.builtins.diagnostics.chktex,
                null_ls.builtins.formatting.beautysh,
                null_ls.builtins.code_actions.shellcheck,
                null_ls.builtins.diagnostics.shellcheck,

                null_ls.builtins.formatting.stylua,
                -- null_ls.builtins.code_actions.refactoring,
                require("typescript.extensions.null-ls.code-actions"),
            },
            border = "rounded",
            on_attach = on_attach,
        })

        nvim_lsp["solidity"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
            filetypes = { "solidity" },
            root_dir = nvim_lsp.util.root_pattern(".git", ".truffle-config.js"),
            single_file_support = true,
        })

        require("typescript").setup({
            disable_commands = false, -- prevent the plugin from creating Vim commands
            debug = false, -- enable debug logging for commands
            go_to_source_definition = {
                fallback = true, -- fall back to standard LSP definition on failure
            },
        })

        -- GO setup
        require("go").setup({
            lsp_cfg = {
                on_attach = on_attach,
                capabilities = capabilities,
            },
        })

        require("neodev").setup()
        nvim_lsp.lua_ls.setup({
            settings = {
                Lua = {
                    workspace = {
                        checkThirdParty = false,
                    },
                },
            },
        })

        local get_servers = require("mason-lspconfig").get_installed_servers
        for _, server_name in ipairs(get_servers()) do
            nvim_lsp[server_name].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end

        vim.g.python_host_prog = "~/.virtualenvs/neovim/bin/python"
        vim.g.python3_host_prog = "~/.virtualenvs/neovim/bin/python3"

        -- Latex setup
        nvim_lsp.ltex.setup({
            cmd = { "texlab" },
            filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex" },
            settings = {},
            root_dir = nvim_lsp.util.root_pattern("main.tex"),
            on_attach = on_attach,
            single_file_support = true,
            capabilities = capabilities,
        })
    end,
}
