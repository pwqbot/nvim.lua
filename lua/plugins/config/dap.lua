local dap, dapui = require("dap"), require("dapui")

local scan = require "plenary.scandir"

local contains = function(tbl, str)
    for _, v in ipairs(tbl) do
        if v == str then
            return true
        end
    end
    return false
end

--- Check if a path
local exists = function(dir, file_pattern)
    local dirs = scan.scan_dir(dir, { depth = 1, search_pattern = file_pattern })
    return contains(dirs, dir .. "/" .. file_pattern)
end


dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    }
}

dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}

dap.defaults.fallback.terminal_win_cmd = "10split new"

dap.configurations.cpp = {
    {
        name = "C++ Debug And Run",
        type = "gdb",
        request = "launch",
        program = function()
            -- First, check if exists CMakeLists.txt
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        runInTerminal = true,
        console = "integratedTerminal",
    },
}

dapui.setup({
    -- layouts = {
    --   {
    --     elements = {
    --       "watches",
    --     },
    --     size = 0.2,
    --     position = "left",
    --   },
    -- },
    controls = {
        enabled = true,
    },
    render = {
        max_value_lines = 3,
    },
    floating = {
        max_height = nil,  -- These can be integers or a float between 0 and 1.
        max_width = nil,   -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
