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
            ts_rainbow2 = true,
            leap = true,
            lsp_trouble = true,
            notify = true,
            lsp_saga = true,
            cmp = true,
            semantic_tokens = true,
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
require("tokyonight").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    light_style = "day",    -- The theme is used when the background is set to light
    transparent = true,     -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "transparent",            -- style for sidebars, see below
        floats = "transparent",              -- style for floating windows
    },
    sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false,             -- dims inactive windows
    lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold
    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors)
    end,
    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors)
    end,
})

vim.cmd [[ colorscheme tokyonight ]]

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
