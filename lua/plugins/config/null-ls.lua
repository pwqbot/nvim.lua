local null_ls = require("null-ls")
local sources = {
    -- null_ls.builtins.diagnostics.cppcheck.with({
    --     extra_args = { "--std" } }),
    -- null_ls.builtins.formatting.autopep8,
    -- null_ls.builtins.formatting.golines.with({
    --     extra_args = { "-m", "80" }
    -- }),
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
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,

            })
        end
    end,
})
