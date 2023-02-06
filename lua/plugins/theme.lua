return {
    { "EdenEast/nightfox.nvim", lazy = true },
    { "sainnhe/everforest", lazy = true },
    { "folke/tokyonight.nvim", lazy = true },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
        config = function()
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
        end
    },
    { 'navarasu/onedark.nvim', lazy = true },
}
