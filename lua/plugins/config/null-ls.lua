local null_ls = require("null-ls")
local sources = {
    -- null_ls.builtins.diagnostics.cppcheck,
    null_ls.builtins.formatting.black,
    -- null_ls.builtins.formatting.golines.with({
    --     extra_args = { "-m", "80" }
    -- }),
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.cmake_lint,
    -- null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.formatting.markdownlint
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    sources = sources,
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,

            })
        end
    end,
})
