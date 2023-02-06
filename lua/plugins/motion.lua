return {
    'rhysd/clever-f.vim',
    {
	'ggandor/leap.nvim',
        config = function()
            require('leap').set_default_keymaps()
            vim.keymap.set('n', 's', function()
                require('leap').leap { target_windows = { vim.fn.win_getid() } }
            end
            )
        end
    },
    'linty-org/readline.nvim',
    'chaoren/vim-wordmotion'
}