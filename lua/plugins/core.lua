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
                    "cmake",
                    "zig"
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
        config = {
            autoswap = true,
        }
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
        keys = {
            { "<C-g>", "<cmd>LazyGit<cr>" }
        }
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
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        keys = {
            {
                "<leader><F1>",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.env.HOME })
                end,
                desc = "Explorer NeoTree (root dir)",
            },
            {
                "<F1>",
                function()
                    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
                end,
                desc = "Explorer NeoTree (cwd)",
            },
        },
        deactivate = function()
            vim.cmd([[Neotree close]])
        end,
        init = function()
            vim.g.neo_tree_remove_legacy_commands = 1
            if vim.fn.argc() == 1 then
                local stat = vim.loop.fs_stat(vim.fn.argv(0))
                if stat and stat.type == "directory" then
                    require("neo-tree")
                end
            end
        end,
        opts = {
            sources = {
                "filesystem",
                "buffers",
                "git_status",
                "document_symbols",
            },
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = true,
                use_libuv_file_watcher = true,
            },
            window = {
                mappings = {
                    -- ["<space>"] = "none",
                },
            },
            source_selector = {
                winbar = true,
                statusline = false
            },
            default_component_configs = {
                indent = {
                    with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
            },
        },
        config = function(_, opts)
            require("neo-tree").setup(opts)
            vim.api.nvim_create_autocmd("TermClose", {
                pattern = "*lazygit",
                callback = function()
                    if package.loaded["neo-tree.sources.git_status"] then
                        require("neo-tree.sources.git_status").refresh()
                    end
                end,
            })
        end,
    },
}
