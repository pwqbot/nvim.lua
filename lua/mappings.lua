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

imap('jk', '<Esc>')
imap('kj', '<Esc>')
nmap('<C-Tab>', 'gt') 
nmap('<C-S-Tab>', 'gT')
nmap('<C-q>', '<cmd>qa<cr>')

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
nmap('<C-t>', '<cmd>Telescope oldfiles<CR>')
nmap('<F3>', '<cmd>Telescope projects<CR>')
imap('<F1>', '<cmd>NvimTreeToggle<CR>')
nmap('<F1>', '<cmd>NvimTreeToggle<CR>')
nmap('<C-f>', [[:lua require('telescope.builtin').find_files{cwd = "~", hidden=true}<CR>]])

vim.cmd [[
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
]]

--- trouble ---
vim.keymap.set('n', "<C-1>", "<cmd>TroubleToggle<cr>", { noremap = true, silent = true })

--- comment ---
vim.keymap.set('n', '<C-_>', require("Comment.api").toggle_current_linewise)
vim.keymap.set('x', '<C-_>', 
    '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>'
)

--- sneak ---
vim.api.nvim_set_keymap('n', 'f', '<Plug>Sneak_s', { noremap = false, silent = true })
vim.api.nvim_set_keymap('n', 'F', '<Plug>Sneak_S', { noremap = false, silent = true })

nmap('<F2>', ':DiffviewOpen<CR>')
local diffview_group = vim.api.nvim_create_augroup("diffview", {})
vim.api.nvim_create_autocmd(
    {"BufWinEnter"},
    {
        group = diffview_group,
        pattern = "DiffviewFilePanel",
        command = [[ nnoremap <F2> <cmd>DiffviewClose<CR> ]]
    })
vim.api.nvim_create_autocmd(
    {"BufWinEnter"},
    {
        group = diffview_group,
        pattern = "DiffviewFilePanel",
        command = [[ nnoremap <F2> <cmd>DiffviewClose<CR> ]]
    })

vim.api.nvim_create_autocmd(
    {"BufDelete","BufHidden"},
    {
        group = diffview_group,
        pattern = "DiffviewFilePanel",
        command = [[ nnoremap <F2> <cmd>DiffviewOpen<CR> ]]
    })

---------------------------- terminal navigation ------------------------------
tmap('<C-j>', [[<C-\><C-n><C-w>j]])
tmap('<C-k>', [[<C-\><C-n><C-w>k]])
tmap('<C-h>', [[<C-\><C-n><C-w>h]])
tmap('<C-l>', [[<C-\><C-n><C-w>l]])

local dd_terminal_buffer = -1
local dd_terminal_window = -1
local dd_terminal_chan_id = -1

function TerminalOpenHorizontal()
    if vim.fn.bufexists(dd_terminal_buffer) == 0 then
        vim.cmd('below new terminal_window')
        vim.cmd('wincmd J')
        vim.cmd('resize 15')
        dd_terminal_chan_id = vim.api.nvim_call_function("termopen", {"$SHELL"})
        vim.cmd([[silent file Terminal_1]])
        vim.cmd([[startinsert]])
        vim.cmd([[set nobuflisted]])
        dd_terminal_window = vim.fn.win_getid()
        dd_terminal_buffer = vim.fn.bufnr('%')
    else 
        if  vim.fn.win_gotoid(dd_terminal_window) == 0 then
            vim.cmd('sp')
            vim.cmd([[wincmd J]])
            vim.cmd([[execute "resize " . 15]])
            vim.cmd([[buffer Terminal_1]])
            vim.cmd([[startinsert]])
            dd_terminal_window = vim.fn.win_getid()
        end
    end
end

function TerminalOpenVeritical()
    if vim.fn.bufexists(dd_terminal_buffer) == 0 then
        vim.cmd('new terminal_window')
        vim.cmd('wincmd L')
        vim.cmd('vertical resize 60')
        dd_terminal_chan_id = vim.api.nvim_call_function("termopen", {"$SHELL"})
        vim.cmd([[silent file Terminal_1]])
        vim.cmd([[startinsert]])
        vim.cmd([[set nobuflisted]])
        dd_terminal_window = vim.fn.win_getid()
        dd_terminal_buffer = vim.fn.bufnr('%')
    else 
        if  vim.fn.win_gotoid(dd_terminal_window) == 0 then
            vim.cmd('vsp')
            vim.cmd([[wincmd L]])
            vim.cmd([[execute "vertical resize " . 60]])
            vim.cmd([[buffer Terminal_1]])
            vim.cmd([[startinsert]])
            dd_terminal_window = vim.fn.win_getid()
        end
    end
end

function TerminalClose()
    if vim.fn.win_gotoid(dd_terminal_window) == 1 then
        vim.cmd('hide')
    end
end

function TerminalToggle()
    if vim.fn.win_gotoid(dd_terminal_window) == 1 then
        TerminalClose() 
    else
        TerminalOpenHorizontal() 
    end
end

function TerminalExec(cmd)
    if vim.fn.win_gotoid(dd_terminal_window) == 0 then
        TerminalOpenVeritical()
    end

    vim.api.nvim_chan_send(dd_terminal_chan_id, "clear\n")
    vim.api.nvim_chan_send(dd_terminal_chan_id, cmd..'\n')
    vim.fn.execute("normal G")
    vim.fn.execute("wincmd p")
    vim.cmd([[ stopinsert ]])
end

vim.api.nvim_set_keymap('n', '<C-`>', '', {
    noremap = true,
    callback = TerminalToggle,
})
vim.api.nvim_set_keymap('t', '<C-`>', '', {
    noremap = true,
    callback = TerminalToggle,
})
vim.api.nvim_set_keymap('t', '<F1>', '<cmd>NvimTreeToggle<CR>', {
    noremap = true,
})

function MapGoRun()
    print("???")
    vim.api.nvim_buf_set_keymap(0,'n','<F5>',
        [[<cmd>call v:lua.TerminalExec('go run '..expand('%'))<CR>]],
        {
            noremap = true,
        })
end

local go_group = vim.api.nvim_create_augroup("go_group", {clear = true})
vim.api.nvim_create_autocmd(
    {'BufWinEnter'},
    {
        group = go_group,
        pattern = "*.go",
        callback = MapGoRun,
    })
