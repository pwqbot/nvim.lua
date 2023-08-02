local opt = vim.opt --- global optlions

vim.wo.fillchars = 'eob: '
vim.cmd 'let $NVIM_TUI_ENABLE_TRUE_COLOR=1'

opt.termguicolors = true
opt.undofile = true
opt.hidden = true
opt.syntax = 'on'
opt.number = true
opt.relativenumber = true
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.autoindent = true
opt.mouse = 'a'
opt.updatetime = 100
opt.ignorecase = true
opt.timeoutlen = 500
opt.laststatus = 3
opt.guicursor = 'a:block-Cursor,i:ver10-CurSearch'
opt.hlsearch = true
opt.incsearch = true
opt.spell = false
opt.spo = 'camel'

opt.scrolloff = 3
opt.signcolumn = "yes:1"
vim.cmd 'set noswapfile'
vim.cmd 'set clipboard=unnamed'

opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.jumpoptions = 'stack'

vim.wo.wrap = false

opt.winbar = '%=%m %f%='
