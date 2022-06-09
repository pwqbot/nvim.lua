# Nvim
git clone this project, then `mv nvim.lua  ~/.config/nvim`.

On first time startup, there will be some errors due to lack of plugins, just type `enter`s to omit errors and run `:PackerSync` in neovim
and restart.

## Install Nerd Font
1. Download Nerd Font https://www.nerdfonts.com/font-downloads
2. Unzip and copy to `~/.fonts`
3. Run the command `fc-cache -fv` to manually rebuild the font cache
4. Run `fc-list` to see all fonts installed

or there will be some text garbled in neovim.

## Go

`lua/settings.lua` has basic setting for neovim.

`lua/keymap` is for keymap, include basic, plugin and lsp.

`lua/lsp` is for language server protocal, which provides code complete, goto definition, code diagnositic...

`lua/plugins` include many useful plugin, like telescope.nvim.

## LSP
Language server protocal can give you the power of go to definition, auto-completion, lints...

### How to add a language server

1. open `lua/lsp/servers.lua`, add server with optional config in `M.servers`.
2. execute `:LspInstallInfo` in neovim, find servername, press `i` to install.
(or you can install language server by yourself, just need to ensure it is executable in `PATH`)
3. execute `:LspInfo` in neovim, to check server has attahed to buffer(with correct file type).

- preconfigured servers
    Here are preconfigured servers, which means you only need to install language server and no need any 
    configuration.
    - clangd for c/c++
    - pylsp for python, support auto detect venv
    - gopls for golang
    - html for html
    - sumneko_lua for lua

### keymaps
once language server is attahed to your buffer(use `:LspInfo` to check), you will get those keymaps.
- `gd` go to symbol definition
- `gr` go to references
- `gi` go to definition
- `<leader>ff` format file
- `<leader>rn` rename symbol in project
- `<leader>ca` code action
- `<leader>e` open diagnositic floating window
- `]d` next diagnositic
- `[d` previous diagnositic

## Plugins

### [Telescope](https://github.com/nvim-telescope/telescope.nvim)
a highly extendable fuzzy finder.
- `CTRL-p` to find files.
- `CTRL-n` to find buffers.
- `<leader>fo` to find recently opened files.
- `<leader>fg` to live grep in project.
- `<leader>fs` to list symbols in current file(need lsp support).
- `<leader>fa` to list symbols in project(need lsp support).
- `F3` to find projects you opened.

### [NvimTree](https://github.com/kyazdani42/nvim-tree.lua)
file explor for neovim. 
In nvimtree, you may check your project structure, add/delete/remove files.
- `F1` toggle nvimtree.
- `g?` in nvimtree, and you will see help.

### [Comment.nvim](https://github.com/numToStr/Comment.nvim)
smart commenting plugin.
- `CRTL-/` to toggle comment, support multiple lines selection.

### [hop.nvim](https://github.com/phaazon/hop.nvim)
move to anywhere with 2 characters.
- press `f`, and there will be characters in your screen, press characters on some position and you will
jump to it.

### [vim-sandwich](https://github.com/machakann/vim-sandwich)
easily edit surrond character
- press `ds"` inside some sentence `"asfasfasadf"`, `""` will be delete.
- press `cs"'` inside some sentence `"asfasfasadf"`, `""` will be replaced with `'asfasfasadf'`.
- press `ysiw"` inside some word `asfasfasadf`, `""` will be added around.

## How to edit keymaps

edit `lua/keymap/common.lua` for common(no plugin, no lsp) keybindings.

edit `lua/keymap/plugin.lua` for plugin keybindings.

edit `lua/keymap/lsp.lua` for lsp keybindings.

## How to remove plugin
1. open `lua/plugins/plugins.lua`, find plugin you want to remove.
2. delete `use xxx`, save file, execute `:source%`, execute `:PackerSync`, press `y` to confirm delete.
