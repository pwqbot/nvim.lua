require 'lsp/nvim-cmp'

local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn",  text = "" },
    { name = "DiagnosticSignHint",  text = "" },
    { name = "DiagnosticSignInfo",  text = "" },
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
            vim.lsp.buf.format({ bufnr = bufnr, async = true })
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

capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- chagne to deep copy
local clangd_capabilities = vim.deepcopy(capabilities)
clangd_capabilities.offsetEncoding = "utf-8"

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

local clangd = require("clangd_extensions").setup {
    server = {
        cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
            "-compile-commands-dir=build",
            "--completion-style=detailed",
            "--clang-tidy",
            "--include-cleaner-stdlib",
            "--log=verbose",
            "--header-insertion=iwyu",
            "--header-insertion-decorators",
            "--pretty",
            "-j=8",
            "--query-driver=/opt/homebrew/bin/g++-12",
        },
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        capabilities = clangd_capabilities,
    },

    extensions = {
        -- defaults:
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,
        -- These apply to the default ClangdSetInlayHints command
        inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",
            -- whether to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
            -- The highlight group priority for extmark
            priority = 100,
        },
        ast = {
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },
            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            },
            highlights = {
                detail = "Comment",
            },
        },
        memory_usage = {
            border = "none",
        },
        symbol_info = {
            border = "none",
        },
    },
}
