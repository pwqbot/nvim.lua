return {
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            "rafamadriz/friendly-snippets",
            "L3MON4D3/LuaSnip",
            "zbirenbaum/copilot-cmp"
        }
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require 'plugins/config/autopairs'
        end
    },
    {
        'L3MON4D3/LuaSnip',
        lazy = true,
        config = function()
            local luasnip = require "luasnip"

            luasnip.config.set_config {
                history = true,
                updateevents = "TextChanged,TextChangedI",
            }

            require("luasnip.loaders.from_vscode").load(
                { paths = '~/.config/nvim/pack/packer/start/friendly-snippets/snippets' }
            )
        end
    },
    {
        "zbirenbaum/copilot.lua",
        event = "VeryLazy",
        config = function()
            vim.defer_fn(function()
                require("copilot").setup(
                    {
                        suggestion = {
                            auto_trigger = false,
                        },
                        filetypes = {
                            yaml = true,
                        }
                    }
                )
            end, 100)
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        lazy = true,
        config = true,    
    }
}
