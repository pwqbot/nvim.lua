set encoding=utf-8
set hidden
set number
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
set autoread
set relativenumber
set tabstop=8
set shiftwidth=8
set softtabstop=8
set noexpandtab
set mouse=a
set autoindent
set showtabline=2
set updatetime=300
set clipboard+=unnamed

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/vim-clang-format'
Plug 'cohama/lexima.vim'

"--- file finder ---"
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

"--- file manager ---"
Plug 'kyazdani42/nvim-web-devicons'

"--- auto change working directory ---"
Plug 'airblade/vim-rooter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"--- theme ---"
" Plug 'hzchirs/vim-material'
" Plug 'joshdick/onedark.vim'
" Plug 'lifepillar/vim-gruvbox8'
" Plug 'projekt0n/github-nvim-theme'
" Plug 'arcticicestudio/nord-vim'

"--- startup ---"
" Plug 'glepnir/dashboard-nvim'

"--- nerd tree---"
" Plug 'ryanoasis/vim-devicons'

" call plug#end()

"--- airline settings ---"
" let g:airline_theme='base16'
" let g:airline_powerline_fonts=1
" let g:airline#extensions#tabline#enabled=1

" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline=1
let g:webdevicons_enable_nerdtree=1
let g:webdevicons_conceal_nerdtree_brackets=1
"--- theme settings ---"
syntax on
" colorscheme nord
" set background=dark


"--- fzf ---"
let g:fzf_layout={ 'window':{'width': 0.9, 'height': 0.6 }}

"--- dashboard ---"
" # let g:dashboard_default_executive='fzf'
" # let g:dashboard_custom_header = [
" # 			\"               ........",
" # 			\"       ..,,',cod,   ..'::.",
" # 			\"      'clloddk0Kc      ;kx,",
" # 			\"     ;oldxkkxxOKc       .::,.",
" # 			\"    ;dodxkkkxxxk;        .',,.",
" # 			\"   ,kxccllodxxkx;        ...';.",
" # 			\"  ;xd::looxk0KKO;         ..;xl.",
" # 			\" ,l::oxdddk0K0Ox;          .cOl.",
" # 			\"'kd..c0k;.......            c0x.",
" # 			\",0O,.:KK:.                  c0d.",
" # 			\".co;.'OKc.                 .l0c",
" # 			\" .'..'okc.                 .ok,",
" # 			\"    .ldl:,'''.''.          .oo.",
" # 			\"     :xllodxkxkk;         .:d;",
" # 			\"     .;lldk00Okk:......''.:l,",
" # 			\"       .;okKKkddoooxO0K0l,:'",
" # 			\"         .oOKXNXKO0KXNXx,..",
" # 			\"          .,lodddddxxdc'",
" # 			\]
" # let g:dashboard_custom_footer = [
" 			# \'May be TLE',
" 	" # \]

let g:clang_format#code_style='Google'
let g:clang_format#detect_style_file=1

autocmd FileType c,cpp,objc ClangFormatAutoEnable
" let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-clangd', 'coc-explorer', 'coc-highlight']

" # let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" # if (has("termguicolors"))
" 	# set termguicolors
" # endif

" # let mapleader = ' '

" # noremap <silent> <Leader>- :vertical resize -5<CR>
" # noremap <silent> <Leader>= :vertical resize +5<CR>
" # noremap <silent> <Leader><Leader>- :resize -5<CR>
" # noremap <silent> <Leader><Leader>= :resize +5<CR>

" # inoremap jj <Esc>
" # nnoremap H ^
" # nnoremap L $
" # noremap <C-j> <C-w>j
" # noremap <C-k> <C-w>k
" # noremap <C-l> <C-w>l
" # noremap <C-h> <C-w>h
" # noremap <C-s> :update<CR>
" # noremap <C-Left> gT
" # noremap <C-Right> gt

"--- fzf --- "
" # noremap <silent> <Leader>f :Files<CR>
" # noremap <silent> <Leader>F :Files ~<CR>
" # noremap <silent> <Leader>h :History<CR>
" noremap <silent> <Leader>b :Buffers<CR>


" nmap <F1> <Cmd>CocCommand explorer<CR>
"--- highlight trailing space ---"
"highlight ExtraWhitespace ctermbg=green guibg=green
"match ExtraWhitespace /\s\+$/
"au BufWinEnter * match ExtraWhitespace /\s\+$/
"au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"au InsertLeave * match ExtraWhitespace /\s\+$/
"au BufWinLeave * call clearmatches()

nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>

"--- remove trailing space ---"
nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
