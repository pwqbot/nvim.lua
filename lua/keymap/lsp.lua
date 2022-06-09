local M = {}

local function map(mode, shortcut, command)
    vim.keymap.set(mode, shortcut, command, { silent = true, noremap = true })
end

local function bufmap(mode, shortcut, command, bufnr)
    vim.keymap.set(mode, shortcut, command,
        { silent = true, noremap = true, buffer = bufnr })
end

local function keymappings(client, bufnr)
    -- local opts = { noremap = true, silent = true }
    map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
    map('n', '[d',
        '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    map('n', ']d',
        '<cmd>lua vim.diagnostic.goto_next()<CR>')
    map('n', '[e',
        '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>')
    map('n', ']e',
        '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>')
    map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>zz', bufnr)
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>zz', bufnr)
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', bufnr)
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', bufnr)
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', bufnr)
    -- bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', bufnr)
    bufmap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', bufnr)
    bufmap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', bufnr)
    bufmap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', bufnr)
    bufmap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', bufnr)
    bufmap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', bufnr)
    bufmap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', bufnr)
    bufmap('n', '<leader>ff', '<cmd>lua vim.lsp.buf.formatting_sync()<CR>', bufnr)
    bufmap('n', '<leader>ic', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', bufnr)
    bufmap('n', '<leader>oc', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', bufnr)
end

function M.setup(client, bufnr)
    keymappings(client, bufnr)
end

return M
