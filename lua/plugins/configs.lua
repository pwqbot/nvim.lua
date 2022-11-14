local theme = {
    ["EdenEast/nightfox.nvim"] = {},
    ["sainnhe/everforest"] = {},
    ['folke/tokyonight.nvim'] = {},
    ["catppuccin/nvim"] = {
        as = "catppuccin",
        config = function()
            local cat_group = vim.api.nvim_create_augroup("cat", {})
            vim.api.nvim_create_autocmd(
                "User",
                {
                    group = cat_group,
                    pattern = "PackerCompileDone",
                    callback = function()
                        vim.cmd "CatppuccinCompile"
                        vim.cmd "colorscheme catppuccin"
                    end
                }
            )
        end
    },
    ['navarasu/onedark.nvim'] = {},
}

local beautify = {
    ['kyazdani42/nvim-web-devicons'] = {},

    -- status line
    ['nvim-lualine/lualine.nvim'] = {
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require 'plugins/config/lualine'
        end,
    },

    -- start up
    ['goolord/alpha-nvim'] = {
        config = function()
            require 'plugins/config/alpha'
        end
    },

    ['folke/lsp-colors.nvim'] = {},

    ["folke/noice.nvim"] = {
        event = "VimEnter",
        config = function()
            require("noice").setup()
            require("notify").setup({
                background_colour = "#000000",
                stages = "slide",
                timeout = 1000,
                top_down = false,
            })
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },

    -- highlight cursorline
    ['mvllow/modes.nvim'] = {
        config = function()
            require('modes').setup({
                set_cursor = false,
                set_cursorline = true,
            })
        end
    },

    ["nvim-zh/colorful-winsep.nvim"] = {
        config = function()
            require('colorful-winsep').setup({})
        end
    },

    ['SmiteshP/nvim-gps'] = {
        requires = 'nvim-treesitter/nvim-treesitter',
        config = function()
            require("nvim-gps").setup()
        end
    },

    ['p00f/nvim-ts-rainbow'] = {},
}

local optimize = {
    -- speed up startup time
    ['nathom/filetype.nvim'] = {},
    ['lewis6991/impatient.nvim'] = {
        config = function()
            -- move this to init.lua
            require 'impatient'
        end
    },
}

local lsp = {

    ["neovim/nvim-lspconfig"] = {
        config = function()
            require 'lsp/lspconfig'
        end
    },

    ["williamboman/mason.nvim"] = {},

    ["williamboman/mason-lspconfig.nvim"] = {
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()
        end
    },

    -- <leader>fx to open lsp diagnostic
    ['folke/trouble.nvim'] = {
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require 'plugins/config/trouble'
        end,
    },

    ['onsails/lspkind.nvim'] = {},

    ["glepnir/lspsaga.nvim"] = {
        branch = "main",
        config = function()
            require 'plugins/config/lspsaga'
        end,
    },

    ["stevearc/aerial.nvim"] = {
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
    ['jose-elias-alvarez/null-ls.nvim'] = {
        config = function()
            require 'plugins/config/null-ls'
        end
    },

    ['p00f/clangd_extensions.nvim'] = {
        config = function()
            require 'plugins/config/clangd'
        end
    },

    ['MrcJkb/haskell-tools.nvim'] = {},

    ['lervag/vimtex'] = {},
}

local complete = {
    ['hrsh7th/nvim-cmp'] = {},
    ['hrsh7th/cmp-nvim-lsp'] = {},
    ['hrsh7th/cmp-nvim-lua'] = {},
    ['hrsh7th/cmp-buffer'] = {},
    ['hrsh7th/cmp-path'] = {},
    ['hrsh7th/cmp-cmdline'] = {},
    ['hrsh7th/cmp-nvim-lsp-signature-help'] = {},
    ["rafamadriz/friendly-snippets"] = {},
    ['L3MON4D3/LuaSnip'] = {
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
    ["zbirenbaum/copilot.lua"] = {
        event = "VimEnter",
        config = function()
            vim.defer_fn(function()
                require("copilot").setup()
            end, 100)
        end,
    },
    ["zbirenbaum/copilot-cmp"] = {
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()


        end
    },
}

local motion = {
    ['rhysd/clever-f.vim'] = {},
    ['ggandor/leap.nvim'] = {
        config = function()
            require('leap').set_default_keymaps()
            vim.keymap.set('n', 's', function()
                require('leap').leap { target_windows = { vim.fn.win_getid() } }
            end
            )
        end
    },
    ['linty-org/readline.nvim'] = {},
    ['chaoren/vim-wordmotion'] = {}
}

local vim_enhance = {
    -- show key hint
    ["folke/which-key.nvim"] = {
        config = function()
            require 'plugins/config/which-key'
        end
    },

    --  jk to ESC
    ["max397574/better-escape.nvim"] = {
        config = function()
            require 'plugins/config/better-escape'
        end,
    },

    -- quickfix window preview
    ['kevinhwang91/nvim-bqf'] = {
        config = function()
            require 'plugins/config/bqf'
        end
    },

    -- powerful c-a/c-x
    ['monaqa/dial.nvim'] = {},

    -- automatically turn off search highlight
    ['haya14busa/is.vim'] = {},

    -- <F1> open file explorer
    ['kyazdani42/nvim-tree.lua'] = {
        config = function()
            require 'plugins/config/filetree'
        end,
        requires = { 'kyazdani42/nvim-web-devicons' },
        cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle", "NvimTreeFocus" }
    },

    ['jpalardy/vim-slime'] = {
        setup = function()
            vim.cmd [[ 
            let g:slime_target = "neovim" 
            let g:slime_no_mappings = 1 
            xmap <leader>1 <Plug>SlimeRegionSend 
            nmap <leader>1 <Plug>SlimeParagraphSend ]]
        end
    },

    ['voldikss/vim-floaterm'] = {
        setup = function()
            vim.cmd [[let g:floaterm_keymap_toggle = '<C-t>']]
            vim.cmd [[let g:floaterm_width = 0.8]]
            vim.cmd [[let g:floaterm_height = 0.8]]
            vim.cmd [[let g:floaterm_autoinsert = 1]]
        end
    },

    --- auto pairs
    ['windwp/nvim-autopairs'] = {
        config = function()
            require 'plugins/config/autopairs'
        end
    },

}

local git = {
    ['kdheepak/lazygit.nvim'] = {},
    ['lewis6991/gitsigns.nvim'] = {
        config = function()
            require 'plugins/config/gitsign'
        end
    },
}

local build_system = {
    ['skywind3000/asynctasks.vim'] = {
        setup = function()
            vim.cmd [[ let g:asynctasks_term_reuse = 1 ]]
            vim.cmd [[ let g:asynctasks_term_pos = 'floaterm_reuse' ]]
            vim.cmd [[let g:asynctasks_term_rows = 6]]
            vim.cmd [[let g:asynctasks_term_cols = 500]]
            vim.cmd [[ let g:asynctasks_term_focus = 1 ]]
        end
    },
    ['GustavoKatel/telescope-asynctasks.nvim'] = {},
    ['xeluxee/competitest.nvim'] = {
        requires = 'MunifTanjim/nui.nvim',
        config = function()
            require 'competitest'.setup()
        end
    },
}

local debug = {
    ['mfussenegger/nvim-dap'] = {
        config = function()
            require 'plugins/config/dap'
        end
    },
    ['rcarriga/nvim-dap-ui'] = {},
    ['leoluz/nvim-dap-go'] = {
        config = function()
            require('dap-go').setup()
        end
    },
}

local treesitter = {
    ['nvim-treesitter/nvim-treesitter']             = {
        config = function()
            require 'plugins/config/tree'
        end
    },
    ['nvim-treesitter/nvim-treesitter-textobjects'] = {
        config = function()
            require 'plugins/config/textobj'
        end
    },
    ['nvim-treesitter/nvim-treesitter-context']     = {
        config = function()
            require 'plugins/config/context'
        end
    },
    ['mizlan/iswap.nvim']                           = {
        config = function()
            require('iswap').setup {
                autoswap = true,
            }
        end
    },
    ['numToStr/Comment.nvim']                       = {
        config = function()
            require 'plugins/config/comment'
        end,
    },
}

local telescope = {
    ['nvim-telescope/telescope-project.nvim'] = {},
    ['nvim-telescope/telescope.nvim'] = {
        config = function()
            require 'plugins/config/tele'
        end,
        requires = {
            'nvim-lua/plenary.nvim',
        },
    },
    ['tom-anders/telescope-vim-bookmarks.nvim'] = {},
    ['MattesGroeger/vim-bookmarks'] = {},

    -- telescope speed up
    ['nvim-telescope/telescope-fzf-native.nvim'] = {
        run = 'make'
    },

    -- auto switch pwd
    ["ahmedkhalf/project.nvim"] = {
        config = function()
            require("project_nvim").setup {
                detection_methods = { "pattern", "lsp" },
                patterns = { ".root", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
            }
        end
    },

    -- add comments with treesitter
    ["folke/todo-comments.nvim"] = {
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins/config/todo")
        end
    },
}

Configs = {
    ['wbthomason/packer.nvim'] = {},
}

local modules = {
    theme,
    beautify,
    optimize,
    lsp,
    complete,
    motion,
    git,
    build_system,
    debug,
    treesitter,
    telescope,
    vim_enhance,
}

for _, module in ipairs(modules) do
    Configs = vim.tbl_deep_extend("force", Configs, module)
end

return Configs
