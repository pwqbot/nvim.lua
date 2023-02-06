return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = { "williamboman/mason-lspconfig.nvim", "williamboman/mason.nvim" },
        config = function()
            require 'lsp/lspconfig'
            require("mason").setup()
            require("mason-lspconfig").setup()
        end
    },

    { "williamboman/mason.nvim", cmd = "Mason" },
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
        end
    },

    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
        end
    },

    -- <leader>fx to open lsp diagnostic
    {
        "folke/trouble.nvim",
        dependencies = 'kyazdani42/nvim-web-devicons',
        config = function()
            require 'plugins/config/trouble'
        end,
    },

    "onsails/lspkind.nvim",
    {
        "DNLHC/glance.nvim",
        config = function()
            local glance = require('glance')
            local actions = glance.actions
            glance.setup({
                border = {
                    enable = true,
                },
                theme = { -- This feature might not work properly in nvim-0.7.2
                    enable = false, -- Will generate colors for the plugin based on your current colorscheme
                    mode = 'darken', -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
                },
                mappings = {
                    list = {
                        ['j'] = actions.next, -- Bring the cursor to the next item in the list
                        ['k'] = actions.previous, -- Bring the cursor to the previous item in the list
                        ['<Down>'] = actions.next,
                        ['<Up>'] = actions.previous,
                        ['<Tab>'] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
                        ['<S-Tab>'] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
                        ['<C-u>'] = actions.preview_scroll_win(5),
                        ['<C-d>'] = actions.preview_scroll_win(-5),
                        ['v'] = actions.jump_vsplit,
                        ['s'] = actions.jump_split,
                        ['t'] = actions.jump_tab,
                        ['o'] = actions.jump,
                        ['<CR>'] = actions.enter_win('preview'),
                        ['q'] = actions.close,
                        ['Q'] = actions.close,
                        ['<Esc>'] = actions.close,
                        -- ['<Esc>'] = false -- disable a mapping
                    },
                    preview = {
                        ['Q'] = actions.close,
                        ['<Tab>'] = actions.next_location,
                        ['<S-Tab>'] = actions.previous_location,
                        ['<leader>l'] = actions.enter_win('list'), -- Focus list window
                    },
                },
                -- your configuration
            })
        end,
    },

    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require 'plugins/config/lspsaga'
        end,
    },

    {
        "stevearc/aerial.nvim",
        config = function()
            require("aerial").setup({
                backends = { "treesitter", "lsp" },
                on_attach = function(bufnr)
                    -- Toggle the aerial window with <leader>a
                    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
                end
            })
        end,
    },

    -- lsp adapter
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require 'plugins/config/null-ls'
        end
    },

    'p00f/clangd_extensions.nvim',
    'MrcJkb/haskell-tools.nvim',
    'lervag/vimtex',
}
