local user_path = vim.fn.expand('~')
Nvim_path = user_path .. [[/.config/nvim/]]
local packer_start_path = Nvim_path .. 'pack/packer/start'
local packer_path = packer_start_path .. '/packer.nvim'
local packer_bootstrap
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    print("install packer")
    packer_bootstrap = vim.fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', packer_path
    })
end

vim.opt.runtimepath:append(packer_start_path .. '/*')

require('packer').init({
    package_root = Nvim_path .. 'pack/',
    profile = {
        enable = true,
        threshold = 0,
    },
    display = {
        open_fn = function()
            return require("packer.util").float { border = 'rounded' }
        end,
    },
    auto_reload_compile = true,
})

vim.cmd [[let g:floaterm_keymap_toggle = '<C-t>']]

vim.cmd [[let g:floaterm_width = 0.8]]
vim.cmd [[let g:floaterm_height = 0.8]]
vim.cmd [[let g:floaterm_autoinsert = 1]]
-- vim.cmd [[let g:floaterm_wintype = 'split']]

-- vim.cmd [[let g:floaterm_position='bottomright']]


vim.cmd [[ let g:asyncrun_open = 6 ]]
vim.cmd [[ let g:asynctasks_term_reuse = 1 ]]
vim.cmd [[ let g:asynctasks_term_pos = 'floaterm_reuse' ]]
vim.cmd [[let g:asynctasks_term_rows = 6]]
vim.cmd [[let g:asynctasks_term_cols = 500]]
vim.cmd [[ let g:asynctasks_term_focus = 1 ]]


require('packer').startup(
    function(use)
        --- packer itself ---
        use 'wbthomason/packer.nvim'
        use 'voldikss/vim-floaterm'


        --------------------------- git ------------------------------
        use {
            'lewis6991/gitsigns.nvim',
            config = function()
                require 'plugins/config/gitsign'
            end
        }

        ---------------------------- vim enhance -----------------------------
        -- automatically turn off search highlight
        use 'haya14busa/is.vim'

        vim.cmd [[ 
            let g:slime_target = "neovim" 
        ]]
        use {
            'jpalardy/vim-slime'
        }
        -- Packer
        use({
            "folke/noice.nvim",
            event = "VimEnter",
            config = function()
                require("noice").setup()
            end,
            requires = {
                -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
                "MunifTanjim/nui.nvim",
                "rcarriga/nvim-notify",
            }
        })

        -- highlight cursorline
        use({
            'mvllow/modes.nvim',
            config = function()
                require('modes').setup({
                    set_cursor = false,
                    set_cursorline = true,
                })
            end
        })

        --  jk to ESC
        use {
            "max397574/better-escape.nvim",
            config = function()
                require 'plugins/config/better-escape'
            end,
        }

        -- quickfix window preview
        use {
            'kevinhwang91/nvim-bqf',
            config = function()
                require 'plugins/config/bqf'
            end
        }

        -- powerful c-a/c-x
        use {
            'monaqa/dial.nvim'
        }

        -- fast motion
        use {
            'ggandor/leap.nvim',
            config = function()
                require('leap').set_default_keymaps()
                vim.keymap.set('n', 's', function()
                    require('leap').leap { target_windows = { vim.fn.win_getid() } }
                end
                )
            end
        }

        -- show key hint
        use {
            "folke/which-key.nvim",
            config = function()
                require 'plugins/config/which-key'
            end
        }

        use {
            'kdheepak/lazygit.nvim'
        }


        --- auto pairs
        use {
            'windwp/nvim-autopairs',
            config = function()
                require 'plugins/config/autopairs'
            end
        }

        -- speed up startup time
        use { 'nathom/filetype.nvim' }
        use {
            'lewis6991/impatient.nvim',
            config = function()
                -- move this to init.lua
                require 'impatient'
            end
        }

        use {
            'xeluxee/competitest.nvim',
            requires = 'MunifTanjim/nui.nvim',
            config = function()
                require 'competitest'.setup()
            end
        }

        use {
            'linty-org/readline.nvim',
        }
        use {
            'skywind3000/asynctasks.vim',
            'skywind3000/asyncrun.vim',
            'GustavoKatel/telescope-asynctasks.nvim',
        }

        -- --------------------------- beautify ----------------------------
        -- theme
        use "EdenEast/nightfox.nvim"
        use "sainnhe/everforest"
        use 'folke/tokyonight.nvim'

        use {
            "catppuccin/nvim",
            as = "catppuccin",
        }
        use 'navarasu/onedark.nvim'

        --  icon
        use 'kyazdani42/nvim-web-devicons'

        -- status line
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = function()
                require 'plugins/config/lualine'
            end,
        }

        -- start up
        use {
            'goolord/alpha-nvim',
            config = function()
                require 'plugins/config/alpha'
            end
        }

        ----------------------------- project navigator ---------------------------
        -- fuzzy finder, see keymap in keymap/plugin.lua
        use { 'nvim-telescope/telescope-project.nvim' }
        use {
            'nvim-telescope/telescope.nvim',
            config = function()
                require 'plugins/config/tele'
            end,
            requires = {
                'nvim-lua/plenary.nvim',
            },
        }
        use {
            'tom-anders/telescope-vim-bookmarks.nvim',
            'MattesGroeger/vim-bookmarks'
        }

        -- telescope speed up
        use {
            'nvim-telescope/telescope-fzf-native.nvim',
            run = 'make'
        }

        -- <F1> open file explorer
        use {
            'kyazdani42/nvim-tree.lua',
            config = function()
                require 'plugins/config/filetree'
            end,
            requires = { 'kyazdani42/nvim-web-devicons' },
            cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle", "NvimTreeFocus" }
        }

        -- auto switch pwd
        use
        {
            "ahmedkhalf/project.nvim",
            config = function()
                require("project_nvim").setup {
                    detection_methods = { "pattern", "lsp" },
                    patterns = { ".root", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
                }
            end
        }

        -- Lua
        use {
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("plugins/config/todo")
            end
        }

        -- --------------------------- code ------------------------------
        use {
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require 'plugins/config/tree'
            end
        }
        use 'p00f/nvim-ts-rainbow'
        use {
            'nvim-treesitter/nvim-treesitter-textobjects',
            config = function()
                require 'plugins/config/textobj'
            end
        }
        use {
            'nvim-treesitter/nvim-treesitter-context',
            config = function()
                require 'plugins/config/context'
            end
        }
        -- show position in code in status line
        use {
            'SmiteshP/nvim-gps',
            requires = 'nvim-treesitter/nvim-treesitter',
            config = function()
                require("nvim-gps").setup()
            end
        }

        -- add comment
        use {
            'numToStr/Comment.nvim',
            config = function()
                require 'plugins/config/comment'
            end,
        }
        use {
            'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui',
            config = function()
                require 'plugins/config/dap'
            end
        }
        use {
            'leoluz/nvim-dap-go',
            config = function()
                require('dap-go').setup()
            end
        }
        -- ---------------------------- LSP --------------------------------
        use {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            {
                "neovim/nvim-lspconfig",
                config = function()
                    require("mason").setup()
                    require("mason-lspconfig").setup()
                    require 'lsp/lspconfig'
                end
            }
        }
        use {
            'lervag/vimtex'
        }


        use({
            "glepnir/lspsaga.nvim",
            branch = "main",
            config = function()
                require 'plugins/config/lspsaga'
            end,
        })

        -- lsp adapter
        use {
            'jose-elias-alvarez/null-ls.nvim',
            config = function()
                require 'plugins/config/null-ls'
            end
        }

        -- beautify
        use 'folke/lsp-colors.nvim'

        use {
            'p00f/clangd_extensions.nvim',
            config = function()
                require 'plugins/config/clangd'
            end
        }

        -- all complete plugins
        use {
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'L3MON4D3/LuaSnip',
            "rafamadriz/friendly-snippets",
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
        }

        -- <leader>a open file structure
        use {
            'stevearc/aerial.nvim',
            config = function()
                require 'plugins/config/aerial'
            end
        }

        -- <leader>fx to open lsp diagnostic
        use {
            'folke/trouble.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function()
                require 'plugins/config/trouble'
            end,
        }

        if packer_bootstrap then
            require('packer').sync()
        end
    end)
