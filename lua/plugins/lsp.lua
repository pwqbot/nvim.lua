return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                "folke/neodev.nvim",
                opts = {
                    library = {
                        plugins = {
                            "nvim-dap-ui"
                        },
                        types = true
                    }
                }
            },
            "williamboman/mason.nvim",
            "glepnir/lspsaga.nvim",
            "onsails/lspkind.nvim",
            "williamboman/mason-lspconfig.nvim",
            'MrcJkb/haskell-tools.nvim',
            "smjonas/inc-rename.nvim",
            'simrat39/rust-tools.nvim',
        },
        config = function()
            require 'lsp/lspconfig'
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = true,
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    "clangd",
                    "rust_analyzer",
                    "bashls",
                    "cmake",
                    "jsonls",
                    "pyright",
                },
            }
        end
    },

    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {
            PATH = "append",
        },
    },
    {
        "smjonas/inc-rename.nvim",
        lazy = true,
        config = true
    },

    -- <leader>fx to open lsp diagnostic
    {
        "folke/trouble.nvim",
        keys = {
            { "<leader>tb", "<cmd>TroubleToggle<cr>" },
        },
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require 'plugins/config/trouble'
        end,
    },

    {
        "glepnir/lspsaga.nvim",
        branch = "main",
        lazy = true,
        config = function()
            require 'plugins/config/lspsaga'
        end,
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" }
        }
    },

    {
        "stevearc/aerial.nvim",
        keys = {
            { "<leader>a", "<cmd>AerialToggle!<cr>" },
        },
        opts = {
            backends = { "treesitter", "lsp" },
            on_attach = function(bufnr)
                -- Toggle the aerial window with <leader>a
                vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>AerialToggle!<CR>', {})
            end
        },
    },

    -- lsp adapter
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "mason.nvim" },
        config = function()
            require 'plugins/config/null-ls'
        end
    },
    'lervag/vimtex',
}
