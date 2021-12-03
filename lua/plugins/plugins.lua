require 'plugins/config/dashboard'
require 'plugins/config/airline'
require 'plugins/config/treesitter'
require 'plugins/config/nerdcomment'
require 'plugins/config/trouble'
require 'plugins/config/fox'
require 'plugins/config/diffview'
require('lspfuzzy').setup {}



local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(
function(use)
	--- packer itself ---
	use 'wbthomason/packer.nvim'

	----------------------------- file ---------------------------
	--- git ---
	use 'tpope/vim-fugitive'
	use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
	use 'airblade/vim-gitgutter'


	--- file finder ---
	use 'junegunn/fzf'
	use 'junegunn/fzf.vim'

	--- file explorer ---
	use 'kevinhwang91/rnvimr'

	--- automatically change pwd ---
	use 'airblade/vim-rooter'

	--- session management ---
	use 'tpope/vim-obsession'

	--- tmux ---
	use 'christoomey/vim-tmux-navigator'

	--- markdown ---
	use {"ellisonleao/glow.nvim"}

	--- undo ---
	use 'simnalamburt/vim-mundo'

	--------------------------- code ------------------------------
	use 'nvim-treesitter/nvim-treesitter'
	use 'rhysd/vim-clang-format'

	--- bracket ---
	use 'cohama/lexima.vim'

	use "machakann/vim-sandwich"

	--- comment ---
	use 'preservim/nerdcommenter'

	--- automatically turn off search highlight ---
	use 'haya14busa/is.vim'

	--- jump by two character ---
	use 'justinmk/vim-sneak'

    --- gdb ---
    use 'puremourning/vimspector'

	--------------------------- beautify ----------------------------
	--- theme ---
	use 'arcticicestudio/nord-vim'
	use 'joshdick/onedark.vim'
	use 'hzchirs/vim-material'
	use 'sainnhe/everforest'
	use 'folke/tokyonight.nvim'
	use 'EdenEast/nightfox.nvim'

	--- icon ---
	use 'kyazdani42/nvim-web-devicons'

	--- status line ---
	use 'vim-airline/vim-airline'
	use 'vim-airline/vim-airline-themes'

	--- start up ---
	use 'glepnir/dashboard-nvim'

	---------------------------- LSP --------------------------------
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
	use {
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	}
	use 'folke/lsp-colors.nvim'
	use {
		'ojroques/nvim-lspfuzzy',
		requires = {
			{'junegunn/fzf'},
			{'junegunn/fzf.vim'},  -- to enable preview (optional)
		},
	}


	if packer_bootstrap then
		require('packer').sync()
	end
end)
