require('telescope').setup{
    layout_config = {
        dropdown = {width=0.5}
    },
    mappings = {
    },
    extensions = {
    },
}

require("telescope").load_extension "projects"
