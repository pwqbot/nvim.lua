local cwd_to_terminal = {}
local dd_terminal_window = -1
local dd_terminal_chan_id = -1

function TerminalOpenHorizontal()
    local cwd = vim.fn.getcwd()
    if cwd_to_terminal[cwd] == nil then
        vim.cmd('below new terminal_window')
        vim.cmd('wincmd J')
        vim.cmd('resize 15')
        local chan_id = vim.api.nvim_call_function("termopen", { "$SHELL" })
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

vim.keymap.set({ 'n', 't' }, '<C-t>', TerminalToggle)

local term_group = vim.api.nvim_create_augroup("toggleterm", { clear = true })
vim.api.nvim_create_autocmd(
    { "BufWinEnter", "WinEnter", "BufEnter", "TermEnter" },
    {
        group = term_group,
        pattern = { "Terminal_*" },
        callback = function()
            vim.keymap.set('n', 'q', TerminalToggle, { buffer = true })
        end,
    })
