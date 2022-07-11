local opt = vim.opt --- global optlions

vim.wo.fillchars = 'eob: '
vim.cmd 'let $NVIM_TUI_ENABLE_TRUE_COLOR=1'

opt.termguicolors = true
opt.undofile = true
opt.hidden = true
opt.syntax = 'on'
opt.number = true
opt.splitbelow = true
opt.splitright = true
opt.laststatus = 2
opt.autoindent = true
opt.mouse = 'a'
opt.updatetime = 100
opt.ignorecase = true
opt.timeoutlen = 500
opt.laststatus = 3
opt.guicursor = 'a:block'

-- opt.cmdheight = 0
opt.scrolloff = 3
opt.signcolumn = "yes:2"
opt.tabstop = 4
vim.cmd 'set noswapfile'
opt.shiftwidth = 4
opt.winbar = '%=%m %f%='
vim.cmd 'set clipboard=unnamed'
opt.expandtab = true
vim.wo.wrap = false
