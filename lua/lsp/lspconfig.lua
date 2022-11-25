require 'lsp/nvim-cmp'

local signs = {
    { name = "DiagnosticSignError", text = "😡" },
    { name = "DiagnosticSignWarn", text = "😥" },
    { name = "DiagnosticSignHint", text = "😤" },
    { name = "DiagnosticSignInfo", text = "😐" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name,
        { texthl = sign.name, text = sign.text, numhl = "" }
    )
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    underline = false,
    -- signwidth = 500,
    -- signcolumn = yes,
    update_in_insert = false, -- delay update diagnostics
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
    severity_sort = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {
        border = "rounded",
    }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
        border = "rounded",
    }
)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    require 'keymap/lsp'.setup(client, bufnr)

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
        end,
    })

    local codelens_group = vim.api.nvim_create_augroup("codelens", {})
    vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter', 'CursorHold',
        'InsertLeave', 'BufWritePost', 'TextChanged' },
        {
            group = codelens_group,
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
        })
end


local capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)
capabilities.offsetEncoding = "utf-8"
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

local default_config = {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities,
}

local ht = require('haskell-tools')
ht.setup {
    tools = { -- haskell-tools options
    },
    hls = {
        -- See nvim-lspconfig's  suggested configuration for keymaps, etc.
        on_attach = on_attach,
    },
}

for name, config in pairs(require('lsp/servers').servers) do
    if config == nil then
        config = default_config
    else
        config = vim.tbl_deep_extend("force", config, default_config)
    end
    require('lspconfig')[name].setup(config)
end
