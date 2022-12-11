return require('packer').startup(function(use)
	-- Telescope
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-telescope/telescope-fzy-native.nvim'
	use 'nvim-telescope/telescope-ui-select.nvim'
	use 'nvim-telescope/telescope-project.nvim'
	use 'tami5/sqlite.lua'
	use 'nvim-telescope/telescope-cheat.nvim'

	-- Treesitter
	use { 'nvim-treesitter/nvim-treesitter', ['do'] = ':TSUpdate' }
	use 'nvim-treesitter/playground'
	use 'nvim-treesitter/nvim-treesitter-context'

	-- debuging
	use 'mfussenegger/nvim-dap'
	use 'rcarriga/nvim-dap-ui'

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

	-- Golang setup
	use { 'fatih/vim-go', ['do'] = ':GoUpdateBinaries' }

	-- Typescript setup
	use 'jose-elias-alvarez/nvim-lsp-ts-utils'

	-- Java setup
	use 'mfussenegger/nvim-jdtls'

	-- Git integration
	use 'tpope/vim-fugitive'

	-- Comments
	use 'tpope/vim-commentary'

	-- Colorscheme
	use { 'dracula/vim', as = 'dracula' }

	-- Line
	use 'itchyny/lightline.vim'

	-- NERDTree
	use 'preservim/nerdtree'
	-- use 'tiagofumo/vim-nerdtree-syntax-highlight'
	use 'johnstef99/vim-nerdtree-syntax-highlight'
	use 'kyazdani42/nvim-web-devicons'
	use 'ryanoasis/vim-devicons'

	-- Tmux
	use 'christoomey/vim-tmux-navigator'
	use 'RyanMillerC/better-vim-tmux-resizer'

	use 'lervag/vimtex'
	use 'lewis6991/spellsitter.nvim'

	-- utils
	use 'jiangmiao/auto-pairs'
	use 'metakirby5/codi.vim'
	use 'luochen1990/rainbow'
	use 'glepnir/dashboard-nvim'
	use 'rcarriga/nvim-notify'
	use 'sbdchd/neoformat'
	use 'folke/trouble.nvim'
end)
