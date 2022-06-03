local user_path = vim.fn.expand('~')
Nvim_path = user_path .. [[/.config/nvim/]]

local packer_start_path = Nvim_path .. 'pack/packer/start'
local packer_path = packer_start_path .. '/packer.nvim'
local packer_bootstrap
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    print("install packer")
    packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_path })
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
            return require("packer.util").float { border = "rounded" }
        end,
    },
})

require('packer').startup(
    function(use)
        --- packer itself ---
        use 'wbthomason/packer.nvim'

        --------------------------- git ------------------------------
        use {
            'lewis6991/gitsigns.nvim',
            config = function()
                require 'plugins/config/gitsign'
            end
        }

        --- F2 ---
        use {
            'TimUntersberger/neogit',
            requires = {
                'nvim-lua/plenary.nvim',
                'sindrets/diffview.nvim',
            },
            config = function()
                require 'plugins/config/neogit'
                require 'plugins/config/diffview'
            end
        }

        ---------------------------- vim -----------------------------
        -- automatically turn off search highlight
        use 'haya14busa/is.vim'

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
        }

        -- fast motion
        use {
            'phaazon/hop.nvim',
            branch = 'v1', -- optional but strongly recommended
            config = function()
                require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
            end
        }

        -- show key hint
        use {
            "folke/which-key.nvim",
            config = function()
                require 'plugins/config/which-key'
            end
        }
        ----------------------------- file ---------------------------
        -- fuzzy finder, see keymap in keymap/plugin.lua
        use {
            'nvim-telescope/telescope.nvim',
            config = function()
                require 'plugins/config/tele'
            end,
            requires = {
                'nvim/lua/plenary.nvim',
            },
        }

        -- <F1> open file explorer
        use {
            'kyazdani42/nvim-tree.lua',
            config = function()
                require 'plugins/config/filetree'
            end,
            requires = {
                'kyazdani42/nvim-web-devicons', -- optional, for file icon
            },
        }

        -- auto switch pwd
        use
        {
            "ahmedkhalf/project.nvim",
            config = function()
                require("project_nvim").setup()
            end
        }
        -- --------------------------- code ------------------------------
        use {
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require 'plugins/config/tree'
            end
        }
        use {
            'nvim-treesitter/nvim-treesitter-textobjects',
            config = function()
                require 'plugins/config/textobj'
            end
        }

        use {
            'stevearc/aerial.nvim',
            config = function()
                require 'plugins/config/aerial'
            end
        }

        -- add comment
        use {
            'numToStr/Comment.nvim',
            config = function()
                require 'plugins/config/comment'
            end,
        }
        -- --------------------------- beautify ----------------------------
        -- theme
        use "EdenEast/nightfox.nvim"

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

        -- show position in code in status line
        use {
            "SmiteshP/nvim-gps",
            requires = "nvim-treesitter/nvim-treesitter",
            config = function()
                require("nvim-gps").setup()
            end
        }

        -- buffer line beautify
        use {
            'akinsho/bufferline.nvim',
            tag = "v2.*",
            config = function()
                require 'plugins/config/bufferline'
            end,
            requires = 'kyazdani42/nvim-web-devicons',
        }

        -- start up
        use {
            'goolord/alpha-nvim',
            config = function()
                require 'plugins/config/alpha'
            end
        }
        -- ---------------------------- LSP --------------------------------
        use {
            'williamboman/nvim-lsp-installer',
            {
                "neovim/nvim-lspconfig",
                config = function()
                    require 'plugins/config/lsp-installer'
                    require 'lsp/lspconfig'
                end
            }
        }

        -- lsp adapter
        use {
            'jose-elias-alvarez/null-ls.nvim',
            config = function()
                require 'plugins/config/null-ls'
            end
        }

        -- beautify
        use 'folke/lsp-colors.nvim'

        -- all complete plugins
        use {
            'hrsh7th/nvim-cmp',
            'L3MON4D3/LuaSnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
        }

        -- <leader>t to open lsp diagnostic
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require 'plugins/config/trouble'
            end,
        }

        if packer_bootstrap then
            require('packer').sync()
        end
    end)
