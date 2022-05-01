function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function xmap(shorcut, command)
	map('x', shorcut, command)
end

function vmap(shorcut, command)
	map('v', shorcut, command)
end

function tmap(shorcut, command)
    map('t', shorcut, command)
end

vim.g.mapleader = ' '
imap('jk', '<Esc>')
imap('kj', '<Esc>')

--- line move ---
map('n','H', '^')
map('v','H', '^')
map('n','L', '$')
map('v','L', '$')

--- move between windows ---
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')
nmap('<C-h>', '<C-w>h')

--- save file ---
nmap('<C-s>', ':update<CR>')

--- jump between buffer/tab ---
nmap('<F8>', 'gT')
nmap('<F7>', 'gt')
nmap(')', '<cmd>bn<CR>')
nmap('(', '<cmd>bprevious<CR>')
nmap('<C-g>', '<cmd>bd<CR>')

--- adjust windows size ---
nmap('<Leader>-', ':vertical resize -5<CR>')
nmap('<Leader>=', ':vertical resize +5<CR>')
nmap('<Leader><Leader>-', ':resize -5<CR>')
nmap('<Leader><Leader>=', ':resize +5<CR>')

--- fuzzf finder ---
nmap('<C-p>', '<cmd>Telescope find_files<CR>')
nmap('<C-n>', '<cmd>Telescope live_grep<CR>')
nmap('<C-b>', '<cmd>Telescope buffers<CR>')
imap('<F1>', '<cmd>NvimTreeToggle<CR>')
nmap('<F1>', '<cmd>NvimTreeToggle<CR>')
nmap('<F3>', '<cmd>Telescope projects<CR>')
nmap('<C-f>', [[:lua require('telescope.builtin').find_files{cwd = "~", hidden=true}<CR>]])

vim.cmd [[
  inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
]]

--- trouble ---
vim.api.nvim_set_keymap('n', "<leader>t", "<cmd>TroubleToggle<cr>", { noremap = true, silent = true })

vmap('<C-_>', ':call nerdcommenter#Comment(0,"toggle")<CR>')
nmap('<C-_>', ':call nerdcommenter#Comment(0,"toggle")<CR>')
nmap('<A-_>', ':call nerdcommenter#Comment(0,"toggle")<CR>')

-- vim.cmd 'tnoremap <Esc> <C-\\><C-n>:bd!<CR>'

--- sneak ---
vim.api.nvim_set_keymap('n', 'f', '<Plug>Sneak_s', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'F', '<Plug>Sneak_S', { noremap = false, silent = true })

nmap('<Leader>df', ':DiffviewOpen<CR>')

-- terminal navigation --
tmap('<C-j>', [[<C-\><C-n><C-w>j]])
tmap('<C-k>', [[<C-\><C-n><C-w>k]])
tmap('<C-h>', [[<C-\><C-n><C-w>h]])
tmap('<C-l>', [[<C-\><C-n><C-w>l]])
tmap('<A-j>', [[<C-\><C-n>:bprevious<CR>]])
tmap('<A-k>', [[<C-\><C-n>:bnext<CR>]])

local term_group = vim.api.nvim_create_augroup("term",{clear = true})
vim.api.nvim_create_autocmd(
{"BufWinEnter","WinEnter"},
{
    group = term_group,
    pattern = "term://*", 
    command = "startinsert",
})

vim.api.nvim_create_autocmd(
{"BufWinEnter","WinEnter", "TermOpen"},
{
    group = term_group,
    pattern = "term://*", 
    command = [[nnoremap <buffer><silent> <C-g> <cmd>bd!<CR>]],
})
vim.api.nvim_create_autocmd(
{"TermOpen"},
{
    group = term_group,
    command = [[set nobuflisted]],
})

-- go to last position when opening a buf
vim.api.nvim_create_autocmd(
"BufReadPost",
{
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
})
