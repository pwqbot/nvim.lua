return {
    'nvim-telescope/telescope-project.nvim',
    -- telescope speed up
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make"
    },
    { 'nvim-telescope/telescope.nvim',
        config = function()
            require 'plugins/config/tele'
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },
    'tom-anders/telescope-vim-bookmarks.nvim',
    'MattesGroeger/vim-bookmarks',



    -- auto switch pwd
    {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {

                detection_methods = { "pattern", "lsp" },
                patterns = { ".root", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
            }
        end
    },

    -- add comments with treesitter
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins/config/todo")
        end
    },
}
