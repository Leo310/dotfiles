-- Setup nvim-cmp.
local cmp = require'cmp'
local lspkind = require'lspkind'
local function fillSpacesToFixed(str, untilLength)
		local untilFixed = untilLength - string.len(str)
		local postfix = ''
		for i = 1, untilFixed, 1 do postfix = postfix .. ' ' end
		return str .. postfix
end

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
	window = {
		completion = {
			border = {
				'╭', '─', '╮', '│', '╯', '─', '╰', '│'
			},
			winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
			scrollbar = '║'
		},
		documentation = {
			winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None',
      scrollbar = '',
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
		fields = {'kind', 'abbr', 'menu'},
		format = function(entry, vim_item)
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
  		if vim_item.menu ~= nil then
					-- buffers with code mostly
					vim_item.menu = fillSpacesToFixed(vim_item.kind, 10) .. vim_item.menu
			end
			vim_item.kind = lspkind.symbolic(vim_item.kind, {with_text = false})
			return vim_item
		end,
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
		{name = 'path'},
		{name = 'cmdline'},
	},
})    
