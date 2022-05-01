local fb_actions = require "telescope".extensions.file_browser.actions

require('telescope').setup{
    layout_config = {
        dropdown = {width=0.5}
    },
    mappings = {
        ["i"] = {
            ["<F1>"] = "jk",
        },
        ["n"] = {
            ["<F1>"] = require('telescope.actions').close
        },
    },
    extensions = {
        file_browser = {
            -- theme = "ivy",
            layout_stategy = 'centor',
            mappings = {
                ["i"] = {
                    ["<F1>"] = require('telescope.actions').close
                },
                ["n"] = {
                    ["<F1>"] = require('telescope.actions').close
                },
            }
        },
	frecency = {
		db_root = "/home/qwqbot/.config/nvim/pack/db"
	}
    },
}

require("telescope").load_extension "file_browser"
require("telescope").load_extension "projects"
