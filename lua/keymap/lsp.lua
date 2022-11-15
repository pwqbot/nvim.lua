local M = {}

local function map(mode, shortcut, command)
    vim.keymap.set(mode, shortcut, command, { silent = true, noremap = true })
end

local function bufmap(mode, shortcut, command, bufnr)
    vim.keymap.set(mode, shortcut, command,
        { silent = true, noremap = true, buffer = bufnr })
end

local saga = require('lspsaga')

local function keymappings(client, bufnr)
    -- local opts = { noremap = true, silent = true }
    map('n', '<leader>e', vim.diagnostic.open_float)
    map('n', '[d',
        '<cmd>Lspsaga diagnostic_jump_prev<CR>')
    map('n', ']d',
        '<cmd>Lspsaga diagnostic_jump_next<CR>')
    map('n', '[e',
        function()
            require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end)
    map('n', ']e',
        function()
            require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
        end)

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    bufmap('n', 'gD', vim.lsp.buf.type_definition, bufnr)
    bufmap('n', 'gd', vim.lsp.buf.definition, bufnr)
    bufmap('n', 'gp', '<cmd>Lspsaga peek_definition<cr>zz', bufnr)
    bufmap('n', 'gh', '<cmd>Lspsaga lsp_finder<cr>', bufnr)
    bufmap('n', 'gr', vim.lsp.buf.references, bufnr)
    bufmap('n', 'gi', vim.lsp.buf.implementation, bufnr)
    bufmap('n', 'K', vim.lsp.buf.hover, bufnr)
    -- bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', bufnr)
    bufmap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufnr)
    bufmap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufnr)
    bufmap('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufnr)
    bufmap('n', '<leader>rn', vim.lsp.buf.rename, bufnr)
    bufmap('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', bufnr)
    bufmap('n', '<leader>ff', function() vim.lsp.buf.format({ bufnr = bufnr }) end, bufnr)
    bufmap('n', '<leader>ic', vim.lsp.buf.incoming_calls, bufnr)
    bufmap('n', '<leader>oc', vim.lsp.buf.outgoing_calls, bufnr)
    bufmap('n', '<leader>cl', vim.lsp.codelens.run, bufnr)
end

function M.setup(client, bufnr)
    keymappings(client, bufnr)
end

return M
