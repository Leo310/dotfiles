-- Setup nvim-cmp.
local cmp = require'cmp'
local lspkind = require'lspkind'

cmp.setup({
	snippet = {
		expand = function(args)
		-- For `vsnip` user.
		vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

		-- For `luasnip` user.
		-- require('luasnip').lsp_expand(args.body)

		-- For `ultisnips` user.
		-- vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	formatting = {
		format = lspkind.cmp_format{
			before = function(entry, vim_item)
					vim_item.menu = ({
						nvim_lsp = "ﲳ",
						nvim_lua = "",
						treesitter = "",
						path = "ﱮ",
						buffer = "﬘",
						zsh = "",
						vsnip = "",
						spell = "暈",
					})[entry.source.name]
					return vim_item
				end,
		},
  },
	view = {                                                        
		entries = {name = 'custom', selection_order = 'near_cursor' } 
	},
	mapping = {
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		-- priority
		{ name = 'nvim_lsp' },
		-- For vsnip user.
		{ name = 'vsnip' },
		{ name = 'buffer' },
	}
})

