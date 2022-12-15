-- For bootstrapping packer the first time
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	-- Packer (for bootstrapping)
	use { "wbthomason/packer.nvim" }

	-- Telescope
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-telescope/telescope-fzy-native.nvim'
	use 'nvim-telescope/telescope-ui-select.nvim'
	use 'nvim-telescope/telescope-project.nvim'

	-- Treesitter
	use { 'nvim-treesitter/nvim-treesitter', ['do'] = ':TSUpdate' }
	use 'nvim-treesitter/playground'
	use 'nvim-treesitter/nvim-treesitter-context'

	-- Copilot
	use {
		"zbirenbaum/copilot.lua",
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup()
			end, 100)
		end,
	}
	use {
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end
	}

	-- debuging / refactoring
	use 'mfussenegger/nvim-dap'
	use 'rcarriga/nvim-dap-ui'
	use 'folke/trouble.nvim'

	-- LSP
	use 'neovim/nvim-lspconfig'
	-- completion
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/nvim-cmp'
	use 'onsails/lspkind.nvim' -- icons of functions. can also define own icons (lookup nvim-cmp wiki -> cuztomize appearance)
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-path'
	-- Vsnip
	use 'hrsh7th/vim-vsnip'
	use 'hrsh7th/cmp-vsnip'
	use 'rafamadriz/friendly-snippets'
	-- Python
	use 'mfussenegger/nvim-dap-python'
	use 'jmcantrell/vim-virtualenv'
	-- Typescript setup
	use 'jose-elias-alvarez/nvim-lsp-ts-utils'
	-- Java setup
	use 'mfussenegger/nvim-jdtls'
	-- Latex
	use 'lervag/vimtex'
	use 'lewis6991/spellsitter.nvim'

	-- Colorscheme
	use { 'dracula/vim', as = 'dracula' }

	-- Nvim Tree
	use 'nvim-tree/nvim-web-devicons'
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional, for file icons
		}
	}

	-- Line
	use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
	use { 'kdheepak/tabline.nvim',
		requires = { { 'hoob3rt/lualine.nvim', opt = true }, { 'kyazdani42/nvim-web-devicons', opt = true } }
	}

	-- Tmux
	use 'christoomey/vim-tmux-navigator'
	use 'RyanMillerC/better-vim-tmux-resizer'

	-- utils
	use 'jiangmiao/auto-pairs'
	use 'glepnir/dashboard-nvim'
	use 'rcarriga/nvim-notify'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-commentary'


	if packer_bootstrap then
		require('packer').sync()
	end
end)
