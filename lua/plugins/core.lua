return {
    {
        "folke/lazy.nvim",
        opts = {
            checker = {
                enableb = true,
            }
        }
    },
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
                ignore_install = {},  -- List of parsers to ignore installing
                highlight = {
                    enable = true,    -- false will disable the whole extension
                    disable = {},     -- list of language that will be disabled
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
        end,
        event = "BufReadPost",
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = {
            enable = true,
            max_lines = 0,
            zindex = 20,
            line_numbers = true,
            mode = 'topline',
            separator = nil,
        },
        event = "BufReadPost",
    },
    {
        "mizlan/iswap.nvim",
        keys = { { "<leader>sw", "<cmd>ISwapWith<cr>" } },
        config = function()
            require('iswap').setup {
                autoswap = true,
            }
        end
    },
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require 'plugins/config/comment'
        end,
    },

    -- Git
    {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit"
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require 'plugins/config/gitsign'
        end
    },
    {
        'sindrets/diffview.nvim',
        keys = {
            { "<leader>gd",  "<cmd>DiffviewOpen<cr>" },
            { "<leader>gdt", "<cmd>DiffviewFileHistory %<cr>" },
        },
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            local actions = require 'diffview.actions'
            require('diffview').setup {
                keymaps = {
                    view = {
                        -- instead of closing one buffer, do `DiffviewClose`
                        ['q'] = actions.close,
                    },
                    file_panel = {
                        ["q"] = "<cmd>tabc<cr>",
                        ["<space>"] = actions.toggle_stage_entry,
                    },
                },
            }
        end
    },
    {
        'windwp/nvim-spectre',
        keys = {
            { "<leader>ss", "<cmd>lua require('spectre').open()<CR>" },
            { "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>' }
        },
    }
}
