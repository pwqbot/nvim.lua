return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        version = false, -- telescope did only one release, so use HEAD for now
        keys = {
            { '<F3>',       function() require 'telescope'.extensions.project.project {} end },
            { '<C-p>',      function() require('telescope.builtin').find_files { hidden = true } end },
            { '<C-b>',      function() require('telescope.builtin').buffers { sort_mru = true } end },
            { '<C-n>',      function() require('telescope.builtin').lsp_dynamic_workspace_symbols {} end },
            { '<C-f>',      function() require('telescope.builtin').lsp_document_symbols {} end },
            { '<leader>gp', function() require('telescope.builtin').live_grep() end },
            { '<leader>fo', function() require('telescope.builtin').oldfiles() end },
            { '<leader>m',  function() require 'telescope'.extensions.vim_bookmarks.all() end },
        },
        dependencies = {
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            'nvim-lua/plenary.nvim',
            "tom-anders/telescope-vim-bookmarks.nvim",
            "nvim-telescope/telescope-dap.nvim",
        },
        config = function()
            require "plugins/config/tele"
        end,
    },
    -- telescope speed up
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        lazy = true
    },
    {
        "MattesGroeger/vim-bookmarks",
        event = "VeryLazy"
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        keys = {
            -- {
            --     '<C-p>',
            --     function()
            --         require("telescope").extensions.frecency.frecency({
            --             sorter = require("telescope").extensions.fzf.native_fzf_sorter(), workspace = 'CWD' })
            --     end
            -- },
            {
                '<C-e>',
                function()
                    require("telescope").extensions.frecency.frecency({
                        sorter = require("telescope").extensions.fzf.native_fzf_sorter() })
                end
            },
        },
        config = function()
            require "telescope".load_extension("frecency")
        end,
        dependencies = {
            "kkharji/sqlite.lua",
            "nvim-telescope/telescope.nvim",
        }
    },

    -- auto switch pwd
    {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        config = function()
            require("project_nvim").setup {
                detection_methods = { "pattern", "lsp" },
                patterns = {
                    ".root", ".git", "_darcs", ".hg",
                    ".bzr", ".svn", "Makefile", "package.json",
                },
            }
        end
    },

    -- add comments with treesitter
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins/config/todo")
        end
    },
}
