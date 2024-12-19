return {
    -- {
    --     'hrsh7th/nvim-cmp',
    --     event = "InsertEnter",
    --     dependencies = {
    --         'hrsh7th/cmp-nvim-lsp',
    --         'hrsh7th/cmp-nvim-lua',
    --         'hrsh7th/cmp-buffer',
    --         'hrsh7th/cmp-path',
    --         'hrsh7th/cmp-cmdline',
    --         'hrsh7th/cmp-nvim-lsp-signature-help',
    --         "rafamadriz/friendly-snippets",
    --         "L3MON4D3/LuaSnip",
    --         "zbirenbaum/copilot-cmp"
    --     }
    -- },
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = {
            { 'rafamadriz/friendly-snippets' },
            { 'L3MON4D3/LuaSnip',            version = 'v2.*' },
            {
                "giuxtaposition/blink-cmp-copilot",
            },
        },

        -- use a release tag to download pre-built binaries
        version = 'v0.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' for mappings similar to built-in completion
            -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
            -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
            -- see the "default configuration" section below for full documentation on how to define
            -- your own keymap.
            keymap = { preset = 'super-tab' },

            appearance = {
                -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                -- Useful for when your theme doesn't support blink.cmp
                -- will be removed in a future release
                use_nvim_cmp_as_default = true,
                -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, via `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
                -- optionally disable cmdline completions
                -- cmdline = {},
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                    },
                },
            },
            snippets = {
                expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
                active = function(filter)
                    if filter and filter.direction then
                        return require('luasnip').jumpable(filter.direction)
                    end
                    return require('luasnip').in_snippet()
                end,
                jump = function(direction) require('luasnip').jump(direction) end,
            },

            -- experimental signature help support
            signature = { enabled = true },

            completion = {
                menu = {
                    draw = {
                        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
                    },
                },

                documentation = {
                    -- Controls whether the documentation window will automatically show when selecting a completion item
                    auto_show = true,
                    -- Delay before showing the documentation window
                    auto_show_delay_ms = 0,
                    -- Delay before updating the documentation window when selecting a new item,
                    -- while an existing item is still visible
                    update_delay_ms = 50,
                    -- Whether to use treesitter highlighting, disable if you run into performance issues
                    treesitter_highlighting = true,
                    window = {
                        min_width = 10,
                        max_width = 60,
                        max_height = 20,
                        border = 'padded',
                        winblend = 0,
                        winhighlight =
                        'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
                        -- Note that the gutter will be disabled when border ~= 'none'
                        scrollbar = true,
                        -- Which directions to show the documentation window,
                        -- for each of the possible menu window directions,
                        -- falling back to the next direction when there's not enough space
                        direction_priority = {
                            menu_north = { 'e', 'w', 'n', 's' },
                            menu_south = { 'e', 'w', 's', 'n' },
                        },
                    },
                },
            }

        },
        -- allows extending the providers array elsewhere in your config
        -- without having to redefine it
        opts_extend = { "sources.default" }
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
