vim.cmd 'let ayucolor="light" '
vim.g.everforest_better_performance = 1

vim.cmd 'set background=dark'

vim.g.everforest_background = 'medium'
vim.g.everforest_enable_italic = 0
vim.g.everforest_transparent_background = 0
vim.g.everforest_show_eob = 0
vim.opt.termguicolors = true

require("catppuccin").setup(
    {
        transparent_background = true,
    }
)

vim.cmd [[ colorscheme catppuccin ]]

-- require('onedark').setup {
--     style = 'cool'
-- }
-- require('onedark').load()
-- vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'
-- vim.cmd 'hi SignColumn guibg=NONE ctermbg=NONE'
-- vim.cmd 'hi NonText guibg=NONE ctermbg=NONE'
-- vim.cmd 'hi! EndOfBuffer ctermbg=255 ctermfg=255 guibg=255 guifg=255'
-- vim.api.nvim_command([[set fillchars=eob:\]])
-- vim.api.nvim_set_hl(0, 'ColorColumn', { fg = "#ffffff", bg = "#212529", })
--
