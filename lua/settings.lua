local opt = vim.opt --- global optlions

vim.cmd 'colorscheme nord'
vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
vim.cmd 'hi SignColumn guibg=NONE ctermbg=NONE'
vim.cmd 'let $NVIM_TUI_ENABLE_TRUE_COLOR=1'
vim.cmd 'set completeopt=menu,noselect'
opt.termguicolors = true
opt.hidden = true
opt.syntax = 'on'
opt.number = true
opt.relativenumber = true
opt.splitbelow = true
opt.splitright = true
opt.laststatus = 2
opt.autoindent = true
opt.mouse = 'a'
opt.updatetime = 300
opt.ignorecase = true
opt.timeoutlen = 300
opt.cmdheight = 2
opt.scrolloff = 1
opt.signcolumn = "yes:2"
opt.tabstop = 4
opt.shiftwidth = 4
vim.wo.wrap = false
vim.cmd 'set inccommand=nosplit'
vim.o.sessionoptions="blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"

--- make ranger replace netrw and be the file explorer ---
vim.g.rnvimr_ex_enable = 1
--- Add a shadow window, value is equal to 100 will disable shadow
vim.g.rnvimr_enable_picker = 1

vim.g.signify_priority = 5
vim.g.webdevicons_enable_airline_statusline=1
vim.cmd [[nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/ss\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>]]
