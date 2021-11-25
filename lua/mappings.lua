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

--- jump between tab ---
nmap('<A-h>', 'gT')
nmap('<A-l>', 'gt')

nmap('<A-k>', ':bnext<CR>')
nmap('<A-j>', ':bprevious<CR>')

--- adjust windows size ---
nmap('<Leader>-', ':vertical resize -5<CR>')
nmap('<Leader>=', ':vertical resize +5<CR>')
nmap('<Leader><Leader>-', ':resize -5<CR>')
nmap('<Leader><Leader>=', ':resize +5<CR>')

--- fuzzf finder ---
nmap('<C-p>', ':Files<CR>')
nmap('<C-[>', ':Files ~<CR>')
nmap('<Leader>b', ':Buffers<CR>')
nmap('<Leader>h', ':History<CR>')

-- nmap('<F1>', ':split term://bash<CR>i')

--- ranger ---
nmap('<F1>', ':RnvimrToggle<CR>')

vim.cmd [[
  inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
]]

--- trouble ---
nmap("<leader>t", "<cmd>TroubleToggle<cr>")


nmap('<Leader>ss', ':<C-u>SessionSave<CR>')
nmap('<Leader>sl', ':<C-u>SessionLoad<CR>')

vim.cmd 'let g:operator_sandwich_no_default_key_mappings = 1'
vim.cmd 'let g:sandwich_no_default_key_mappings = 1'
vim.cmd 'let g:operator_sandwich_no_default_key_mappings = 1'
vim.cmd 'let g:textobj_sandwich_no_default_key_mappings = 1'

nmap('cla', '<Plug>(operator-sandwich-add)')
xmap('cld', '<Plug>(operator-sandwich-delete)')
xmap('clr', '<Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-query-a)')

vmap('<C-_>', ':call nerdcommenter#Comment(0,"toggle")<CR>')
nmap('<C-_>', ':call nerdcommenter#Comment(0,"toggle")<CR>')
nmap('<Leader><C-_>', ':call nerdcommenter#Comment(0,"sexy")<CR>')
vmap('<Leader><C-_>', ':call nerdcommenter#Comment(0,"sexy")<CR>')
nmap('<A-_>', ':call nerdcommenter#Comment(0,"toggle")<CR>')



-- vim.cmd 'tnoremap <Esc> <C-\\><C-n>:bd!<CR>'
nmap('<Leader>gg', '20<C-w>k')
nmap('<Leader>G', '20<C-w>j')

--- sneak ---
vim.cmd 'map f <Plug>Sneak_s'
vim.cmd 'map F <Plug>Sneak_S'
nmap('<Leader>sa', ':SignifyDiff<CR>')
-- vim.cmd 'let g:sneak#label = 1'

nmap('<Leader>df', ':DiffviewOpen<CR>')
