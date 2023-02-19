return {
    "skywind3000/asyncrun.vim",
    {
        "skywind3000/asynctasks.vim",
        config = function()
            vim.cmd [[ let g:asynctasks_term_reuse = 1 ]]
            vim.cmd [[ let g:asynctasks_term_pos = 'floaterm_reuse' ]]
            vim.cmd [[let g:asynctasks_term_rows = 6]]
            vim.cmd [[let g:asynctasks_term_cols = 500]]
            vim.cmd [[ let g:asynctasks_term_focus = 1 ]]
        end
    },
    "GustavoKatel/telescope-asynctasks.nvim",
    {
        "xeluxee/competitest.nvim",
        dependencies = 'MunifTanjim/nui.nvim',
        config = function()
            require 'competitest'.setup()
        end
    },
}
