local function map(mode, shortcut, command)
    vim.keymap.set(mode, shortcut, command, { silent = true, noremap = true })
end

--- quick exit ---
map('n', '<C-q>', '<cmd>qa<cr>')

--- cycle through tab ---
map('n', '<M-h>', 'gT')
map('n', '<M-l>', 'gt')
-- map('n', '<leader>nt', '<Cmd>tabnew<CR>')
map('n', '<leader>ct', '<Cmd>tabclose<CR>')
map('n', '<leader>cb', '<Cmd>bd<CR>')

--- line move ---
map({ 'n', 'v' }, 'H', '^')
map({ 'n', 'v' }, 'L', '$')

--- move between windows ---
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-h>', '<C-w>h')

--- save file ---
map('n', '<C-s>', ':update<CR>')
map('i', '<C-s>', '<ESC>l:update<CR>')

--- adjust windows size ---
map('n', '<C-Left>', ':vertical resize -5<CR>')
map('n', '<C-Right>', ':vertical resize +5<CR>')
map('n', '<C-Down>', ':resize -5<CR>')
map('n', '<C-Up>', ':resize +5<CR>')

--- terminal navigation ---
map('t', '<C-j>', [[<C-\><C-n><C-w>j]])
map('t', '<C-k>', [[<C-\><C-n><C-w>k]])
map('t', '<C-h>', [[<C-\><C-n><C-w>h]])
map('t', '<C-l>', [[<C-\><C-n><C-w>l]])
map('t', '<M-h>', '<C-\\><C-n>gT')
map('t', '<M-l>', '<C-\\><C-n>gt')

--- emacs like ---
map('i', '<C-A>', '<Home>')
map('i', '<C-E>', '<End>')
map('i', '<C-F>', '<Right>')
map('i', '<C-B>', '<Left>')

map('n', '<leader>sc',
    [[:execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>]])

map('n', '<M-j>', ":m .+1<CR>==")
map('n', '<M-k>', ":m .-2<CR>==")
map('v', '<M-j>', ":m '>+1<CR>gv=gv")
map('v', '<M-k>', ":m '<-2<CR>gv=gv")
map('n', '<CR>', 'o<ESC>')
