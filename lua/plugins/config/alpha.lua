local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'


dashboard.section.header.val = {
    [[]],
    [[]],
    [[]],
    [[ ██████╗ ██╗    ██╗ ██████╗     ██████╗  ██████╗ ████████╗]],
    [[██╔═══██╗██║    ██║██╔═══██╗    ██╔══██╗██╔═══██╗╚══██╔══╝]],
    [[██║   ██║██║ █╗ ██║██║   ██║    ██████╔╝██║   ██║   ██║]],
    [[██║▄▄ ██║██║███╗██║██║▄▄ ██║    ██╔══██╗██║   ██║   ██║]],
    [[╚██████╔╝╚███╔███╔╝╚██████╔╝    ██████╔╝╚██████╔╝   ██║]],
    [[ ╚══▀▀═╝  ╚══╝╚══╝  ╚══▀▀═╝     ╚═════╝  ╚═════╝    ╚═╝]],
    [[]],
    [[]],
    [[]],
}

dashboard.section.header.opts = {
    position = "center",
    hl = "Function",
}

local entrys = {
    { "<leader>fo", "       Recent ", ":Telescope oldfiles<CR>" },
    { "<F3>", "     ﳑ  Project", ":Telescope projects<CR>" },
    { ":ene <CR>", "       New    ", ":ene <CR>" },
    { ":qa<CR>", "       Out    ", ":qa<CR>" },
}

local buttons = {}

for _, entry in pairs(entrys) do
    local on_press = function()
        local sc_ = entry[1]
        local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
        vim.api.nvim_feedkeys(key, "normal", false)
    end

    local button = dashboard.button(entry[1], entry[2], entry[3])
    button.opts = {
        position = "center",
        hl = "Aqua",
        align_shortcut = "right",
        hl_shortcut = "Number",
        cursor = 0,
        width = 50,
    }
    button.on_press = on_press
    table.insert(buttons, button)
end

dashboard.section.buttons.val = buttons

dashboard.section.footer.opts = {
    position = "center",
    hl = "White",
}
dashboard.section.footer.val = {
    [[]],
    [[]],
    [[May be TLE]],
}

dashboard.config.opts.noautocmd = true
alpha.setup(dashboard.config)
