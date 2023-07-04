return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Flash Treesitter Search",
            },
        },
    },
    {
        "rgroli/other.nvim",
        keys = {
            {
                "<C-]>",
                "<cmd>:Other test<CR>",
            },
        },
        config = function()
            require("other-nvim").setup({
                showMissingFiles = true,
                mappings = {
                    {
                        pattern = "/test/unit/(.*)/(.*)_test.cpp$",
                        target = "/include/*/%1/%2.hpp",
                        context = "test",
                    },
                    {
                        pattern = "/include/[a-zA-Z]*/(.*)/(.*).hpp$",
                        target = "/test/unit/%1/%2_test.cpp",
                        context = "test",
                    },
                    {
                        pattern = "/include/[a-zA-Z]*/(.*).hpp$",
                        target = "/test/unit/%1_test.cpp",
                        context = "test",
                    },
                }
            })
        end
    },
    {
        'ggandor/leap.nvim',
        keys = {
            {
                's',
                function()
                    require('leap').leap { target_windows = { vim.fn.win_getid() } }
                end
            },
        },
        config = function()
            require('leap').set_default_keymaps()
        end
    },
    {
        'linty-org/readline.nvim',
        keys = {
            { '<M-f>', function() require('readline').forward_word() end,  mode = { 'i' } },
            { '<M-b>', function() require('readline').backward_word() end, mode = { 'i' } },
            {
                '<C-a>',
                '<C-o>^',
                mode = 'i'
            },
            {
                '<C-e>',
                function()
                    require('readline').end_of_line()
                end,
                mode = 'i'
            },
            {
                '<C-k>',
                function()
                    require('readline').kill_line()
                end,
                mode = 'i'
            },
            {
                '<C-f>',
                '<Right>',
                mode = 'i'
            },
            {
                '<C-b>',
                '<Left>',
                mode = 'i'
            }

        }
    },
    {
        'chaoren/vim-wordmotion',
        config = function()
            vim.cmd [[ let g:wordmotion_spaces = '_-.' ]]
        end,
    }
}
