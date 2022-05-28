local user_path = vim.fn.expand('~')
nvim_path = user_path .. [[/.config/nvim/]]

local packer_start_path = nvim_path .. 'pack/packer/start'
local packer_path = packer_start_path .. '/packer.nvim'
local packer_bootstrap
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    print("install packer")
    packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_path })
end

vim.opt.runtimepath:append(packer_start_path .. '/*')
-- vim.opt.runtimepath:append(nvim_path)
-- vim.opt.runtimepath:append(nvim_path.. 'pack/')
-- vim.opt.runtimepath:append(packer_path)

require('packer').init({
    package_root = nvim_path .. 'pack/',
    -- compile_path = nvim_path .. 'pack/packer_compiled.lua',
    profile = {
        enable = true,
        threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
})

return require('packer').startup(
    function(use)
        --- packer itself ---
        use 'wbthomason/packer.nvim'

        --------------------------- git ------------------------------
        use {
            'sindrets/diffview.nvim',
            requires = 'nvim-lua/plenary.nvim',
            config = function()
                require 'plugins/config/diffview'
            end,
        }
        use {
            'lewis6991/gitsigns.nvim',
            config = function()
                require 'plugins/config/gitsign'
            end
        }
        use {
            'TimUntersberger/neogit',
            requires = 'nvim-lua/plenary.nvim'
        }

        ---------------------------- vim -----------------------------
        -- automatically turn off search highlight
        use 'haya14busa/is.vim'
        use {
            "max397574/better-escape.nvim",
            config = function()
                require 'plugins/config/better-escape'
            end,
        }
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
        use {
            "folke/which-key.nvim",
            config = function()
                require("which-key").setup {
                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                }
            end
        }


        ----------------------------- file ---------------------------
        use {
            'nvim-telescope/telescope.nvim',
            config = function()
                require 'plugins/config/tele'
            end,
            requires = {
                'nvim/lua/plenary.nvim',
            },
        }
        use {
            'kyazdani42/nvim-tree.lua',
            config = function()
                require 'plugins/config/filetree'
            end,
            requires = {
                'kyazdani42/nvim-web-devicons', -- optional, for file icon
            },
        }
        use
        {
            "ahmedkhalf/project.nvim",
            config = function()
                require("project_nvim").setup()
            end
        }

        use 'ldelossa/litee.nvim'
        use 'ldelossa/litee-calltree.nvim'
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

        -- --- add comment ---
        use {
            'numToStr/Comment.nvim',
            config = function()
                require 'plugins/config/comment'
            end,
        }


        -- --------------------------- beautify ----------------------------
        -- theme
        use 'joshdick/onedark.vim'
        use 'hzchirs/vim-material'
        use 'sainnhe/everforest'
        use 'folke/tokyonight.nvim'
        use 'sonph/onehalf'
        use 'altercation/vim-colors-solarized'
        use 'overcache/NeoSolarized'
        use 'cocopon/iceberg.vim'
        use 'ayu-theme/ayu-vim'

        --  icon
        use 'kyazdani42/nvim-web-devicons'
        --
        -- status line
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', opt = true },
            config = function()
                require 'plugins/config/lualine'
            end,
        }
        use {
            "SmiteshP/nvim-gps",
            requires = "nvim-treesitter/nvim-treesitter",
            config = function()
                require("nvim-gps").setup()
            end
        }
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
            'jose-elias-alvarez/null-ls.nvim',
            config = function()
                require 'plugins/config/null-ls'
            end
        }
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
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use 'hrsh7th/nvim-cmp'
        use 'L3MON4D3/LuaSnip'
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require 'plugins/config/trouble'
            end,
        }
        use 'folke/lsp-colors.nvim'

        if packer_bootstrap then
            require('packer').sync()
        end
    end)
