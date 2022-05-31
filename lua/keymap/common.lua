local function map(mode, shortcut, command)
    vim.keymap.set(mode, shortcut, command, { silent = true, noremap = true })
end

--- quick exit ---
map('n', '<C-q>', '<cmd>qa<cr>')

--- cycle through tab ---
map('n', '(', 'gt')
map('n', ')', 'gT')

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
map('t', '<F7>', '<C-\\><C-n>gt')
map('t', '<F8>', '<C-\\><C-n>gT')

--- emacs like ---
map('i', '<C-A>', '<Home>')
map('i', '<C-E>', '<End>')
map('i', '<C-F>', '<Right>')
map('i', '<C-B>', '<Left>')
