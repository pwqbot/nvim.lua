local function map(mode, shortcut, command)
    vim.keymap.set(mode, shortcut, command, { silent = true })
end

local function nmap(shortcut, command)
    map('n', shortcut, command)
end

local function imap(shortcut, command)
    map('i', shortcut, command)
end

local function xmap(shorcut, command)
    map('x', shorcut, command)
end

local function vmap(shorcut, command)
    map('v', shorcut, command)
end

local function tmap(shorcut, command)
    map('t', shorcut, command)
end

imap('jk', '<Esc>')
imap('kj', '<Esc>')
nmap('<C-Tab>', 'gt')
nmap('<C-S-Tab>', 'gT')
nmap('<C-q>', '<cmd>qa<cr>')

--- line move ---
map({ 'n', 'v' }, 'H', '^')
map({ 'n', 'v' }, 'L', '$')

--- move between windows ---
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')
nmap('<C-h>', '<C-w>h')

--- save file ---
nmap('<C-s>', ':update<CR>')
imap('<C-s>', '<ESC>l:update<CR>')

--- jump between buffer/tab ---
nmap(')', '<cmd>BufferLineCycleNext<CR>')
nmap('(', '<cmd>BufferLineCyclePrev<CR>')
nmap('<C-g>', '<cmd>b#<CR><cmd>bd#<CR>')

--- adjust windows size ---
nmap('<Leader>-', ':vertical resize -5<CR>')
nmap('<Leader>=', ':vertical resize +5<CR>')
nmap('<Leader><Leader>-', ':resize -5<CR>')
nmap('<Leader><Leader>=', ':resize +5<CR>')

--- fuzzf finder ---
map('n', '<F3>', function() require('telescope').extensions.projects.projects {} end)
map('n', '<F4>', function() require('telescope.builtin').find_files { cwd = "~", hidden = true } end)
map('n', '<C-t>', function() require('telescope.builtin').oldfiles() end)
map('n', '<C-b>', function() require('telescope.builtin').buffers { sort_mru = true } end)
map('n', '<C-n>', function() require('telescope.builtin').live_grep() end)
map('n', '<C-p>', function() require('telescope.builtin').find_files { hidden = true } end)
map('n', '<C-f>', function() require('telescope.builtin').lsp_document_symbols {} end)
map('n', '<C-a>', function() require('telescope.builtin').lsp_dynamic_workspace_symbols {} end)
map({ 't', 'n' }, '<F1>', '<cmd>NvimTreeToggle<CR>')

vim.cmd [[
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
]]

--- trouble ---
vim.keymap.set('n', "<C-1>", "<cmd>TroubleToggle<cr>", { noremap = true, silent = true })

--- comment ---
map('n', '<C-_>', require("Comment.api").toggle_current_linewise)
map('x', '<C-_>',
    '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>'
)

map('n', '<F2>', ':DiffviewOpen<CR>')
local diffview_group = vim.api.nvim_create_augroup("diffview", {})
vim.api.nvim_create_autocmd(
    { "BufWinEnter" },
    {
        group = diffview_group,
        pattern = "DiffviewFilePanel",
        command = [[ nnoremap <F2> <cmd>DiffviewClose<CR> ]]
    }
)

vim.api.nvim_create_autocmd(
    { "BufDelete", "BufHidden" },
    {
        group = diffview_group,
        pattern = "DiffviewFilePanel",
        command = [[ nnoremap <F2> <cmd>DiffviewOpen<CR> ]]
    }
)

---------------------------- terminal navigation ------------------------------
tmap('<C-j>', [[<C-\><C-n><C-w>j]])
tmap('<C-k>', [[<C-\><C-n><C-w>k]])
tmap('<C-h>', [[<C-\><C-n><C-w>h]])
tmap('<C-l>', [[<C-\><C-n><C-w>l]])
tmap('<C-Tab>', [[<C-\><C-n>gt]])
tmap('<C-S-Tab>', [[<C-\><C-n>gT]])

local cwd_to_terminal = {}
local dd_terminal_buffer = -1
local dd_terminal_window = -1
local dd_terminal_chan_id = -1
local dd_terminal_cwd = ""

function TerminalOpenHorizontal()
    local cwd = vim.fn.getcwd()
    if cwd_to_terminal[cwd] == nil then
        vim.cmd('below new terminal_window')
        vim.cmd('wincmd J')
        vim.cmd('resize 15')
        chan_id = vim.api.nvim_call_function("termopen", { "$SHELL" })
        vim.cmd([[silent file Terminal_]] .. tostring(vim.fn.bufnr('%')))

        cwd_to_terminal[cwd] = {
            window = vim.fn.win_getid(),
            buffer = vim.fn.bufnr('%'),
            chan = chan_id,
        }
    else
        if vim.fn.win_gotoid(cwd_to_terminal[cwd].window) == 0 then
            vim.cmd('sp')
            vim.cmd([[wincmd J]])
            vim.cmd([[execute "resize " . 15]])
            vim.cmd([[buffer Terminal_]] .. tostring(cwd_to_terminal[cwd].buffer))
            cwd_to_terminal[cwd].window = vim.fn.win_getid()
        end
    end
end

function TerminalClose()
    vim.cmd('hide')
    vim.cmd('stopinsert')
end

function TerminalToggle()
    local cwd = vim.fn.getcwd()
    if cwd_to_terminal[cwd] ~= nil and vim.fn.win_gotoid(cwd_to_terminal[cwd].window) == 1 then
        TerminalClose()
    else
        TerminalOpenHorizontal()
    end
end

function TerminalExec(cmd)
    if vim.fn.win_gotoid(dd_terminal_window) == 0 then
        TerminalOpenHorizontal()
    end

    vim.api.nvim_chan_send(dd_terminal_chan_id, "clear\n")
    vim.api.nvim_chan_send(dd_terminal_chan_id, cmd .. '\n')
    vim.fn.execute("normal G")
    vim.fn.execute("wincmd p")
    vim.cmd([[ stopinsert ]])
end

map({ 'n', 't' }, '<C-`>', TerminalToggle)

function MapGoRun()
    vim.api.nvim_buf_set_keymap(0, 'n', '<F5>',
        [[<cmd>call v:lua.TerminalExec('go run '..expand('%'))<CR>]],
        {
            noremap = true,
        })
end

local go_group = vim.api.nvim_create_augroup("go_group", { clear = true })
vim.api.nvim_create_autocmd(
    { 'BufWinEnter' },
    {
        group = go_group,
        pattern = "*.go",
        callback = MapGoRun,
    })

map('n', 'f', function()
    require 'hop'.hint_words({})
end
)
