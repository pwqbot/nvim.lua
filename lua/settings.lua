local opt = vim.opt --- global optlions

-- vim.cmd 'let ayucolor="light" '
vim.cmd 'set background=dark'
vim.g.everforest_background = 'soft'
vim.g.everforest_enable_italic = 0
vim.g.everforest_transparent_background = 1
vim.g.everforest_show_eob = 0
vim.cmd [[ colorscheme everforest ]]

-- vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
-- vim.cmd 'hi SignColumn guibg=NONE ctermbg=NONE'
-- vim.cmd 'hi NonText guibg=NONE ctermbg=NONE'
-- vim.cmd 'hi! EndOfBuffer ctermbg=255 ctermfg=255 guibg=255 guifg=255'
vim.api.nvim_command([[set fillchars=eob:\]])
vim.wo.fillchars = 'eob: '
vim.cmd 'let $NVIM_TUI_ENABLE_TRUE_COLOR=1'
vim.cmd 'set completeopt=menu,noselect'

opt.pumheight=10
opt.termguicolors = true
opt.undofile = true
opt.hidden = true
opt.syntax = 'on'
opt.number = true
opt.relativenumber = true
opt.splitbelow = true
opt.splitright = true
opt.laststatus = 2
opt.autoindent = true
opt.mouse = 'a'
opt.updatetime = 100
opt.ignorecase = true
opt.timeoutlen = 300
opt.cmdheight = 2
opt.scrolloff = 1
opt.signcolumn = "yes:2"
opt.tabstop = 4
opt.shiftwidth = 4
vim.cmd 'set clipboard=unnamed'
opt.expandtab = true
vim.wo.wrap = false
vim.cmd 'set inccommand=nosplit'
vim.o.sessionoptions="blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"

vim.g.gitgutter_sign_priority = 15
vim.g.webdevicons_enable_airline_statusline=1
vim.cmd [[nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/ss\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>]]
