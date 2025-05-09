require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "cpp",
        "go",
        "rust",
        "c",
        "python",
        "lua",
        "html",
        "javascript",
        "css",
        "bash",
        "vim",
        "json",
        "haskell",
        "regex",
        "markdown",
        "markdown_inline",
        "cmake",
        "zig"
    },
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = {},  -- List of parsers to ignore installing
    highlight = {
        enable = true,    -- false will disable the whole extension
        disable = {},     -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = ' ',
            scope_incremental = '<TAB>',
            node_incremental = ' ',
            node_decremental = '<S-TAB>',
        },
    },
}
