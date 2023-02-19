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
        compile = {
            enabled = true,
            path = vim.fn.stdpath "cache" .. "/catppuccin",
            suffix = "_compiled"
        },
        integrations = {
            nvimtree = {
                enabled = true,
                show_root = true,
                transparent_panel = false,
            },
            dap = {
                enabled = true,
                enable_ui = true,
            },
            which_key = true,
            lightspeed = true,
            ts_rainbow = true,
            leap = true,
            lsp_trouble = true,
            lsp_saga = true,
            cmp = true,
        }
    }
)
vim.api.nvim_set_hl(0, "NvimDapVirtualText", { fg = "#82E0AA" })
vim.api.nvim_set_hl(0, "DapStoppedLineBG", { bg = "#0B5345" })
vim.api.nvim_set_hl(0, "DapStoppedLineFG", { fg = "#0B5345" })
vim.api.nvim_set_hl(0, "DapBreakpointLineBG", { bg = "#000000" })
vim.api.nvim_set_hl(0, "DapBreakpointLineFG", { fg = "#000000" })
vim.g.catppuccin_flavour = "mocha"
vim.fn.sign_define("DapBreakpoint",
    { text = "", texthl = "Error", linehl = "DapBreakpointLineBG", numhl = "" })
vim.fn.sign_define("DapStopped",
    { text = "", texthl = "DapStoppedLineFG", linehl = "DapStoppedLineBG", numhl = "" })
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
