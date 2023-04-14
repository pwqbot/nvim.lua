vim.cmd 'let ayucolor="light" '
vim.g.everforest_better_performance = 1

vim.cmd 'set background=dark'

vim.g.everforest_background = 'medium'
vim.g.everforest_enable_italic = 0
vim.g.everforest_transparent_background = 0
vim.g.everforest_show_eob = 0
vim.opt.termguicolors = true

vim.api.nvim_set_hl(0, "NvimDapVirtualText", { fg = "#82E0AA" })
vim.api.nvim_set_hl(0, "DapStoppedLineBG", { bg = "#0B5345" })
vim.api.nvim_set_hl(0, "DapStoppedLineFG", { fg = "#0B5345" })
vim.api.nvim_set_hl(0, "DapBreakpointLineBG", { bg = "#000000" })
vim.api.nvim_set_hl(0, "DapBreakpointLineFG", { fg = "#000000" })
vim.fn.sign_define("DapBreakpoint",
    { text = "", texthl = "Error", linehl = "DapBreakpointLineBG", numhl = "" })
vim.fn.sign_define("DapStopped",
    { text = "", texthl = "DapStoppedLineFG", linehl = "DapStoppedLineBG", numhl = "" })

vim.cmd [[ colorscheme tokyonight ]]
