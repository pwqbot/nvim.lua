require('lspsaga').setup(
    {
        finder = {
            --percentage
            max_height = 0.8,
            keys = {
                jump_to = 'p',
                edit = { 'o', '<CR>' },
                vsplit = '<C-v>',
                split = '<C-i>',
                tabe = '<C-t>',
                tabnew = 'r',
                quit = { 'q', '<ESC>' },
                close_in_preview = '<ESC>'
            },
        },
        definition = {
            edit = "<CR>",
            vsplit = "<C-v>",
            split = "<C-i>",
            tabe = "<C-t>",
            quit = "q",
            close = "<Esc>",
        },
        diagnostic = {
            show_code_action = true,
            show_source = true,
            jump_num_shortcut = true,
            --1 is max
            max_width = 0.7,
            custom_fix = nil,
            custom_msg = nil,
            text_hl_follow = false,
            border_follow = true,
            keys = {
                exec_action = "o",
                quit = "q",
                go_action = "g"
            },
        },
        lightbulb = {
            enable = true,
            enable_in_insert = true,
            sign = true,
            sign_priority = 40,
            virtual_text = false,
        },
        code_action = {
            num_shortcut = true,
            show_server_name = true,
            extend_gitsigns = false,
            keys = {
                -- string | table type
                quit = "q",
                exec = "<CR>",
            },
        },
        symbol_in_winbar = {
            enable = false,
            separator = " ",
            hide_keyword = true,
            show_file = true,
            folder_level = 2,
            respect_root = false,
            color_mode = true,
        },
        ui = {
            -- Currently, only the round theme exists
            theme = "round",
            -- This option only works in Neovim 0.9
            title = true,
            -- Border type can be single, double, rounded, solid, shadow.
            border = "rounded",
            winblend = 0,
            expand = "",
            collapse = "",
            preview = " ",
            code_action = "💡",
            diagnostic = "🐞",
            incoming = " ",
            outgoing = " ",
            hover = ' ',
            kind = {},
        },
    }
)
