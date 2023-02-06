return {
    -- speed up startup time
    "nathom/filetype.nvim",
    {
        "lewis6991/impatient.nvim",
        config = function()
            -- move this to init.lua
            require 'impatient'
        end
    },
}
