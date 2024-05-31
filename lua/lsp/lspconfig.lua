require 'lsp/nvim-cmp'

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name,
        { texthl = sign.name, text = sign.text, numhl = "" }
    )
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
            prefix = "",
            severity_sort = true,
        },
        signs = true,
        underline = true,
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
            vim.lsp.buf.format({ bufnr = bufnr, async = true })
        end,
    })

    if client.supports_method("textDocument/codeLens", { bufnr = bufnr }) then
        vim.lsp.codelens.refresh({ bufnr = bufnr })
        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
            buffer = bufnr,
            callback = function()
                vim.lsp.codelens.refresh({ bufnr = bufnr })
            end,
        })
    end

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
    end
end


local capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)
capabilities.offsetEncoding = "utf-8"

capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

local default_config = {
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 50,
    },
    capabilities = capabilities,
}


local rt = require('rust-tools')
rt.setup({
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                -- assist = {
                --     importGranularity = "module",
                --     importPrefix = "by_self",
                -- },
                cargo = {
                    loadOutDirsFromCheck = true,
                },
                callInfo = {
                    full = true,
                },
                procMacro = {
                    enable = true,
                },
                -- diagnostics = {
                --     enable = true,
                --     disabled = { "unresolved-proc-macro" },
                --     enableExperimental = true,
                --     warningsAsHint = {},
                -- },
            },
        },
    }
})

-- local ht = require('haskell-tools')
-- ht.setup {
--     tools = { -- haskell-tools options
--     },
--     hls = {
--         -- See nvim-lspconfig's  suggested configuration for keymaps, etc.
--         on_attach = on_attach,
--     },
-- }

for name, config in pairs(require('lsp/servers').servers) do
    if config == nil then
        config = default_config
    else
        config = vim.tbl_deep_extend("force", config, default_config)
    end
    require('lspconfig')[name].setup(config)
end
