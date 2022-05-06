-- go to last position when opening a buf
local buf_group = vim.api.nvim_create_augroup("buf_group", {})
vim.api.nvim_create_autocmd(
    {"BufReadPost"},
    {
        group = buf_group,
        command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
    })

local yank_group = vim.api.nvim_create_augroup("yank", {})
vim.api.nvim_create_autocmd(
    {"TextYankPost"},
    {
        group = yank_group,
        callback = function()
            require('vim.highlight').on_yank({higroup = 'DiffText', timeout =300})
        end,
    })

local term_group = vim.api.nvim_create_augroup("term",{clear = true})
vim.api.nvim_create_autocmd(
    {"BufWinEnter","WinEnter"},
    {
        group = term_group,
        pattern = {"Terminal_*", "term://*"},
        command = "startinsert",
    })


vim.api.nvim_create_autocmd(
    {"BufWinEnter","WinEnter", "TermOpen"},
    {
        group = term_group,
        pattern = {"Terminal_*","term://*"},
        command = [[nnoremap <buffer><silent> <C-g> <cmd>bd!<CR>]],
    })

vim.api.nvim_create_autocmd(
    {"TermOpen"},
    {
        group = term_group,
        pattern = {"Terminal_*","term://*"},
        command = [[set nobuflisted]],
    })
