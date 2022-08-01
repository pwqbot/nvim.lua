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
opt.guicursor = 'a:block-Cursor,i:block-CurSearch'
opt.hlsearch = false
opt.incsearch = true

opt.scrolloff = 3
opt.signcolumn = "yes:2"
vim.cmd 'set noswapfile'
vim.cmd 'set clipboard=unnamed'

opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true

vim.wo.wrap = false

-- nvim 0.8 feature
-- opt.cmdheight = 0
-- opt.winbar = '%=%m %f%='
