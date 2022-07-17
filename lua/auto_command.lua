-- go to last position when opening a buf
local buf_group = vim.api.nvim_create_augroup("buf_group", {})
vim.api.nvim_create_autocmd(
    { "BufReadPost" },
    {
        group = buf_group,
        command = [[if line("'\"") > 1 && line("'\"") <= line("$") 
        | execute "normal! g`\"" | endif]],
    }
)

local yank_group = vim.api.nvim_create_augroup("yank", {})
vim.api.nvim_create_autocmd(
    { "TextYankPost" },
    {
        group = yank_group,
        callback = function()
            require('vim.highlight').on_yank({
                higroup = 'DiffText', timeout = 300,
            })
        end,
    }
)

local term_group = vim.api.nvim_create_augroup("term", { clear = true })
vim.api.nvim_create_autocmd(
    { "BufWinEnter", "WinEnter", "TermOpen" },
    {
        group = term_group,
        pattern = { "Terminal_*", "term://*" },
        command = "startinsert",
    })
vim.api.nvim_create_autocmd(
    { "BufWinEnter", "WinEnter", "BufEnter", "TermEnter" },
    {
        group = term_group,
        pattern = { "term://*" },
        callback = function()
            vim.keymap.set('n', 'q', "<cmd>close<cr>",
                { silent = true, buffer = true })
        end,
    }
)
vim.api.nvim_create_autocmd(
    { "TermOpen" },
    {
        group = term_group,
        pattern = { "Terminal_*", "term://*" },
        command = [[set nobuflisted]],
    }
)

local quick_exit_group = vim.api.nvim_create_augroup("quick_exit", {})
vim.api.nvim_create_autocmd(
    { "FileType" },
    {
        group = quick_exit_group,
        pattern = { "qf,help,man,checkhealth,lspinfo" },
        callback = function()
            vim.keymap.set('n', 'q', "<cmd>close<cr>",
                { silent = true, buffer = true })
        end
    }
)

local git_group = vim.api.nvim_create_augroup("git", {})
vim.api.nvim_create_autocmd(
    { "FocusGained", "BufEnter", "BufWinEnter" },
    {
        group = git_group,
        pattern = { "*" },
        command = [[checktime]],
    }
)

local tab_group = vim.api.nvim_create_augroup("tab", {})
vim.api.nvim_create_autocmd(
    { "FileType" },
    {
        group = tab_group,
        pattern = { "go" },
        callback = function()
            vim.opt_local.expandtab = false
        end
    }
)

local file_type = vim.api.nvim_create_augroup("filetype", {})
vim.api.nvim_create_autocmd(
    { "BufEnter" },
    {
        group = tab_group,
        pattern = { ".clang-tidy", ".clang-format" },
        command = [[set filetype=yaml]]
    }
)

local cat_group = vim.api.nvim_create_augroup("cat", {})
vim.api.nvim_create_autocmd(
    "User",
    {
        group = cat_group,
        pattern = "PackerCompileDone",
        callback = function()
            vim.cmd "CatppuccinCompile"
            vim.cmd "colorscheme catppuccin"
        end
    }
)
