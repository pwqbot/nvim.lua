return {
    {
        'rhysd/clever-f.vim',
        keys = {
            { "f" },
        }
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
