return {
    {
        "luukvbaal/stabilize.nvim",
        config = true,
    },
    {
        "folke/lazy.nvim",
        opts = {
            checker = {
                enableb = true,
            }
        }
    },
    "nathom/filetype.nvim",
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        dependencies = {
            "HiPhish/nvim-ts-rainbow2",
            "RRethy/nvim-treesitter-textsubjects"
        },
        build = ":TSUpdate",
        event = "BufReadPost",
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = {
                    "cpp",
                    "go",
                    "rust",
                    "c",
                    "python",
                    "lua",
                    "html",
                    "javascript",
                    "css",
                    "bash",
                    "vim",
                    "json",
                    "norg",
                    "haskell",
                    "regex",
                    "markdown",
                    "markdown_inline",
                    "cmake"
                },
                sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
                ignore_install = {}, -- List of parsers to ignore installing
                highlight = {
                    enable = true, -- false will disable the whole extension
                    disable = {}, -- list of language that will be disabled
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
                textsubjects = {
                    enable = true,
                    prev_selection = ',', -- (Optional) keymap to select the previous selection
                    keymaps = {
                        ['.'] = 'textsubjects-smart',
                        [';'] = 'textsubjects-container-outer',
                        ['i;'] = 'textsubjects-container-inner',
                    },
                },
                indent = {
                    enable = true
                },
                rainbow = {
                    enable = true,
                    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                    -- colors = {}, -- table of hex strings
                    -- termcolors = {} -- table of colour name strings
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = ' ',
                        scope_incremental = '<TAB>',
                        node_incremental = ' ',
                        node_decremental = '<S-TAB>',
                    },
                },
            }
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            require 'plugins/config/textobj'
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
            require 'plugins/config/context'
        end
    },
    {
        "mizlan/iswap.nvim",
        config = function()
            require('iswap').setup {
                autoswap = true,
            }
        end
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require 'plugins/config/comment'
        end,
    },

    -- Git
    "kdheepak/lazygit.nvim",
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require 'plugins/config/gitsign'
        end
    },
}
