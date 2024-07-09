require("better_escape").setup {
    timeout = vim.o.timeoutlen,
    mappings = {
        i = {
            j = {
                -- These can all also be functions
                k = "<Esc>",
                j = false,
            },

        },
        c = {
            j = {
                k = "<Esc>",
                j = false,
            },
        },
        t = {
            j = {
                k = false,
                j = false,
            },
        },
        v = {
            j = {
                k = false,
            },
        },
        s = {
            j = {
                k = "<Esc>",
            },
        },
    },
}
