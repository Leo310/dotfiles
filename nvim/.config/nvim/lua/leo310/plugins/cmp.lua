return {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'onsails/lspkind.nvim', -- icons of functions. can also define own icons (lookup nvim-cmp wiki -> cuztomize appearance)
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-path',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
    },
    config = function()
        -- Setup nvim-cmp.
        local cmp = require 'cmp'
        local lspkind = require 'lspkind'
        local function fillSpacesToFixed(str, untilLength)
            local untilFixed = untilLength - string.len(str)
            local postfix = ''
            for i = 1, untilFixed, 1 do postfix = postfix .. ' ' end
            return str .. postfix
        end

        vim.opt.completeopt = "menu,menuone,noselect"
        local luasnip = require("luasnip")
        luasnip.filetype_extend("javascript", { "html" })
        luasnip.filetype_extend("javascriptreact", { "html" })
        luasnip.filetype_extend("typescriptreact", { "html" })
        require("luasnip.loaders.from_vscode").lazy_load()


        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            window = {
                completion = {
                    border = {
                        '╭', '─', '╮', '│', '╯', '─', '╰', '│'
                    },
                    winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
                    -- scrollbar = '║'
                },
                documentation = {
                    winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
                    -- scrollbar = '',
                    border = {
                        '─',
                        '─',
                        '╮',
                        '│',
                        '╯',
                        '─',
                        '─',
                        ''
                    }
                },
            },
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    vim_item.menu = ({
                        nvim_lsp = "ﲳ",
                        nvim_lua = "",
                        treesitter = "",
                        path = "ﱮ",
                        buffer = "B﬘",
                        copilot = "",
                        zsh = "",
                        luasnip = "",
                        spell = "暈",
                    })[entry.source.name]
                    if vim_item.menu ~= nil then
                        -- buffers with code mostly
                        vim_item.menu = fillSpacesToFixed(vim_item.kind, 10) .. vim_item.menu
                    end
                    vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = false })
                    return vim_item
                end,
            },
            view = {
                entries = { name = 'custom', selection_order = 'near_cursor' }
            },
            mapping = {
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<C-Space>'] = cmp.mapping.complete({}),
                ['<C-e>'] = cmp.mapping({
                    i = function()
                        if cmp.visible() then
                            cmp.abort()
                        else
                            cmp.complete()
                        end
                    end,
                    c = function()
                        if cmp.visible() then
                            cmp.close()
                        else
                            cmp.complete()
                        end
                    end,
                }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            },
            sources = {
                -- { name = "copilot" },
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'path' },
            }
        })

        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                name = 'buffer'
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'path' },
                { name = 'cmdline' },
            },
        })
    end
}
