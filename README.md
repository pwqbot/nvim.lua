# Oh NO
	Hi, you love neovim, right?		

## Install Nerd Font
1. Download a Nerd Font https://www.nerdfonts.com/font-downloads
2. Unzip and copy to `~/.fonts`
3. Run the command `fc-cache -fv` to manually rebuild the font cache

or there will be some text garbled.

## Go

`lua/settings.lua` has basic setting for neovim.

`lua/keymap` is for keymap, include basic, plugin and lsp.

`lua/lsp` is for language server protocal, which provides code complete, goto definition, code diagnositic...

`lua/plugins` include many useful plugin, like telescope.nvim.

## How to map key

edit `lua/keymap/common.lua` for common(no plugin, no lsp) keybindings.
edit `lua/keymap/plugin.lua` for plugin keybindings.
edit `lua/keymap/lsp.lua` for lsp keybindings.

## How to add a language server

1. open `lua/lsp/servers.lua`, add server with optional config in `M.servers`.
2. execute `:LspInstallInfo` in neovim, find servername, press `i` to install.
3. execute `:LspInfo` in neovim, to check server has attahed to buffer(with correct file type).

## How to remove plugin
1. open `lua/plugins/plugins.lua`, find plugin you want to remove.
2. delete `use xxx`, save file, execute `:source%`, execute `:PackerSync`, press `y` to confirm delete.
