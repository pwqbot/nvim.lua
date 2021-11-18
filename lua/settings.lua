local opt = vim.opt --- global options

vim.cmd 'colorscheme everforest'
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
opt.timeoutlen = 100
opt.cmdheight = 2
opt.scrolloff = 1
vim.wo.wrap = false
vim.cmd 'set inccommand=nosplit'

--- make ranger replace netrw and be the file explorer ---
vim.g.rnvimr_ex_enable = 1
--- Add a shadow window, value is equal to 100 will disable shadow
vim.g.rnvimr_enable_picker = 1

local opts = {
	log_level = 'info',
	auto_session_enable_last_session = false,
	auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
	uto_session_enabled = true,
	uto_save_enabled = nil,
	uto_restore_enabled = nil,
	uto_session_suppress_dirs = nil
}

---require('auto-session').setup(opts)

vim.o.sessionoptions="blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
