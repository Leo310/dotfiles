vim.opt.mouse = 'a'

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 1000

-- colorscheme set to 0 to have transparent in transparent terminal
vim.g.dracula_colorterm = 0
vim.cmd('colorscheme dracula')

-- Copy to system Clipboard (cross platform)
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
