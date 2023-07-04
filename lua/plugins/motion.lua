return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
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
