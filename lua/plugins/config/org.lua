require('neorg').setup {
    -- ... -- check out setup part...
    load = {
        ["core.defaults"] = {},
        -- ["core.norg.concealer"] = {},
        ["core.gtd.base"] = {
            config = {
                workspace = "gtd",
            }
        },
        ["core.gtd.ui"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    gtd = "~/org/gtd",
                    work = "~/org/work",
                    home = "~/org/home",
                }
            }
        },
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp",
            },
        },
    }
}
