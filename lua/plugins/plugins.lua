require 'plugins/config/dashboard'
require 'plugins/config/airline'
require 'plugins/config/treesitter'

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = {
		prefix = "O",
	},
}
)

return require('packer').startup(
function(use)
	--- packer itself ---
	use 'wbthomason/packer.nvim'

	--- file finder ---
	use 'junegunn/fzf'
	use 'junegunn/fzf.vim'

	--- file explorer ---
	use 'kevinhwang91/rnvimr'

	--- automatically change pwd ---
	use 'airblade/vim-rooter'

	--- automatically turn off search highlight ---
	use 'haya14busa/is.vim'

	use 'justinmk/vim-sneak'
 
	--------------------------- code ------------------------------
	use 'nvim-treesitter/nvim-treesitter'
	use 'rhysd/vim-clang-format'
	
	--- bracket ---
	use 'cohama/lexima.vim'

	use 'gcmt/wildfire.vim'
	use "machakann/vim-sandwich"
	
	
	--------------------------- beautify ----------------------------
	--- theme ---
	use 'arcticicestudio/nord-vim'
	use 'joshdick/onedark.vim'
	use 'hzchirs/vim-material'
	use 'sainnhe/everforest'

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

	--- session management ---
	---use 'rmagatti/auto-session'
	use 'tpope/vim-obsession'

	use 'preservim/nerdcommenter'

	if packer_bootstrap then
		require('packer').sync()
	end
end)
