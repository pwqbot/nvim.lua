return {
    -- show key hint
    {
        "folke/which-key.nvim",
        config = function()
            require 'plugins/config/which-key'
        end
    },

    --  jk to ESC
    {
        "max397574/better-escape.nvim",
        config = function()
            require 'plugins/config/better-escape'
        end,
    },

    -- quickfix window preview
    {
        'kevinhwang91/nvim-bqf',
        config = function()
            require 'plugins/config/bqf'
        end
    },

    -- powerful c-a/c-x
    'monaqa/dial.nvim',

    -- automatically turn off search highlight
    'haya14busa/is.vim',

    -- resize window
    {
        'anuvyklack/windows.nvim',
        event = "VeryLazy",
        dependencies = {
            "anuvyklack/middleclass",
            -- "anuvyklack/animation.nvim"
            -- disable due to
            -- https://github.com/anuvyklack/windows.nvim/issues/23
        },
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require('windows').setup({
                autowidth = {			--		       |windows.autowidth|
                    enable = true,
                    winwidth = 30,			--		        |windows.winwidth|
                    filetype = {			--	      |windows.autowidth.filetype|
                        help = 2,
                    },
                },
                ignore = {
                    buftype = { 'quickfix', 'terminal' },
                },
                animation = {
                    enable = true,
                    duration = 300,
                    fps = 120,
                    easing = "in_out_sine"
                }
            })
        end
    },

    -- <F1> open file explorer
    { 'kyazdani42/nvim-tree.lua',
        config = function()
            require 'plugins/config/filetree'
        end,
        mependencies = { 'kyazdani42/nvim-web-devicons' },
        cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle", "NvimTreeFocus" }
    },

    { 'jpalardy/vim-slime',
        init = function()
            vim.cmd [[
            let g:slime_target = "neovim"
            let g:slime_no_mappings = 1
            ]]
        end
    },

    {
        "voldikss/vim-floaterm",
        init = function()
            vim.cmd [[let g:floaterm_keymap_toggle = '<C-t>']]
            vim.cmd [[let g:floaterm_width = 0.8]]
            vim.cmd [[let g:floaterm_height = 0.8]]
            vim.cmd [[let g:floaterm_autoinsert = 1]]
        end
    },
}
