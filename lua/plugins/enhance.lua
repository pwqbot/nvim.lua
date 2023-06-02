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
    {
        'monaqa/dial.nvim',
        keys = {
            { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true },
            { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true },
            { "<C-a>", function() return require("dial.map").inc_visual() end, expr = true, mode = "v" },
            { "<C-x>", function() return require("dial.map").dec_visual() end, expr = true, mode = "v" },
        },
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group {
                -- default augends used when no group name is specified
                default = {
                    augend.integer.alias.decimal,  -- nonnegative decimal number (0, 1, 2, 3, ...)
                    augend.integer.alias.hex,      -- nonnegative hex number  (0x01, 0x1a1f, etc.)
                    augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
                    augend.constant.alias.bool,    -- boolean value (true <-> false)
                    augend.constant.new {
                        elements = { "and", "or" },
                        word = true,   -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
                        cyclic = true, -- "or" is incremented into "and".
                    },
                    augend.constant.new {
                        elements = { "&&", "||" },
                        word = false,
                        cyclic = true,
                    },
                },
            }
        end
    },

    -- automatically turn off search highlight
    'haya14busa/is.vim',

    -- {
    --     'lukas-reineke/indent-blankline.nvim',
    --     event = { "BufReadPost" },
    --     config =
    --     {
    --         -- for example, context is off by default, use this to turn it on
    --         show_current_context = false,
    --         show_current_context_start = true,
    --     }
    -- },

    -- resize window
    {
        'anuvyklack/windows.nvim',
        event = "BufReadPost",
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
                autowidth = {
                    --		       |windows.autowidth|
                    enable = true,
                    winwidth = 30, --		        |windows.winwidth|
                    filetype = {   --	      |windows.autowidth.filetype|
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
    {
        'jpalardy/vim-slime',
        init = function()
            vim.cmd [[
            let g:slime_target = "neovim"
            let g:slime_no_mappings = 1
            ]]
        end
    },

    {
        'akinsho/toggleterm.nvim',
        version = "*",
        keys = {
            { "<C-t>", "<cmd>ToggleTerm<CR>", noremap = true, silent = true },
        },
        opts = {
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.6
                end
            end,
            insert_mappings = true,
            terminal_mappings = true,
            direction = 'vertical',
            open_mapping = [[<c-t>]],
            winbar = {
                enabled = true,
                name_formatter = function(term) --  term: Terminal
                    return term.name
                end
            },
            autochdir = true,
            float_opts = {
                -- The border key is *almost* the same as 'nvim_open_win'
                -- see :h nvim_open_win for details on borders however
                -- the 'curved' border is a custom border type
                -- not natively supported but implemented in this plugin.
                border = 'curved',
                -- like `size`, width and height can be a number or function which is passed the current terminal
                winblend = 3,
            },
            auto_scroll = false,
        },
        config = function(_, opts)
            require("toggleterm").setup(opts)
            function _G.set_terminal_keymaps()
                local opts = { buffer = 0 }
                vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
                vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            end

            -- if you only want these mappings for toggle term use term://*toggleterm#* instead
            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        end
    },

    {
        'willothy/flatten.nvim',
        config = true,
        lazy = false,
        priority = 1001,
    }
}
