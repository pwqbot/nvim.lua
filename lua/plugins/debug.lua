return {
    { 'mfussenegger/nvim-dap',
        config = function()
            require 'plugins/config/dap'
        end
    },
    "rcarriga/nvim-dap-ui",
    {
        "leoluz/nvim-dap-go",
        config = function()
            require('dap-go').setup()
        end
    },
}
