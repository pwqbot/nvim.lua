user_path = vim.fn.expand('~')
vim.g.nvim_path = user_path .. [[/.config/nvim/]]
vim.opt.runtimepath:append(vim.g.nvim_path)
vim.opt.packpath = vim.g.nvim_path

local packer_start_path = vim.g.nvim_path .. 'pack/packer/start'
vim.opt.runtimepath:append(packer_start_path .. '/*')
local packer_path = packer_start_path .. '/packer.nvim'

local packer_bootstrap
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    print("!!")
    packer_bootstrap = vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_path })
end

vim.cmd [[ packadd packer.nvim ]]

require('packer').init({
    package_root = vim.g.nvim_path .. 'pack/',
    compile_path = vim.g.nvim_path .. 'pack/packer_compiled.lua'
})

require('packer').startup(
    function(use)
    --- packer itself ---
    use 'wbthomason/packer.nvim'

    --------------------------- git ------------------------------
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }

    use 'lewis6991/gitsigns.nvim'

    ----------------------------- file ---------------------------
    -- using packer.nvim
    use { 'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons',
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim/lua/plenary.nvim',
        },
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
    }
    use "ahmedkhalf/project.nvim"

    --- tmux ---
    use 'christoomey/vim-tmux-navigator'

    use 'akinsho/toggleterm.nvim'
    --------------------------- code ------------------------------
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    --- bracket ---
    use 'cohama/lexima.vim'

    --- add comment ---
    use {
        'numToStr/Comment.nvim',
    }

    --- automatically turn off search highlight ---
    use 'haya14busa/is.vim'

    --- jump by two character ---
    use {
        'phaazon/hop.nvim',
        branch = 'v1', -- optional but strongly recommended
    }
    --------------------------- beautify ----------------------------
    --- theme ---
    use 'joshdick/onedark.vim'
    use 'hzchirs/vim-material'
    use 'sainnhe/everforest'
    use 'folke/tokyonight.nvim'
    use 'sonph/onehalf'
    use 'altercation/vim-colors-solarized'
    use 'overcache/NeoSolarized'
    use 'cocopon/iceberg.vim'
    use 'ayu-theme/ayu-vim'

    --- icon ---
    use 'kyazdani42/nvim-web-devicons'

    --- status line ---
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'

    --- start up ---
    -- use 'glepnir/dashboard-nvim'
    use {
        'goolord/alpha-nvim',
    }

    ---------------------------- LSP --------------------------------
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    }
    use 'folke/lsp-colors.nvim'

    if packer_bootstrap then
        require('packer').sync()
    end
end)

require 'plugins/config/lsp-installer'
require 'plugins/config/airline'
require 'plugins/config/tree'
require 'plugins/config/nerdcomment'
require 'plugins/config/trouble'
require 'plugins/config/diffview'
require 'plugins/config/tele'
require 'plugins/config/filetree'
require 'plugins/config/gitsign'
require("project_nvim").setup()
require 'plugins/config/toggle'
require 'plugins/config/textobj'
require 'plugins/config/alpha'
require 'plugins/config/comment'
require 'plugins/config/bufferline'
require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
require 'plugins/config/null-ls'
