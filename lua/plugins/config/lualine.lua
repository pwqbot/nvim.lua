local git_blame = require('gitblame')
-- This disables showing of the blame text next to the cursor
vim.g.gitblame_display_virtual_text = 0

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = {
            {
                'filename',
                path = 1,
                file_staus = true,
                color = { fg = "#fcc2d7" },
            },
        },
        lualine_c = {
            { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
        },
        lualine_x = {
            {
                'branch',
                color = { fg = "#99e9f2" },
            },
            'diff',
            'diagnostics',
        },
        lualine_y = { 'filetype', 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = { 'nvim-tree', 'quickfix', 'man', 'lazy', 'trouble', 'neo-tree', 'toggleterm' }
}
