return {
    {
        "Shatur/neovim-cmake",
        config = function()
            local Path = require('plenary.path')
            require('cmake').setup({
                cmake_executable = 'cmake',                                                    -- CMake executable to run.
                save_before_build = true,                                                      -- Save all buffers before building.
                parameters_file = 'neovim.json',                                               -- JSON file to store information about selected target, run arguments and build type.
                default_parameters = { args = {}, build_type = 'Debug' },                      -- The default values in `parameters_file`. Can also optionally contain `run_dir` with the working directory for applications.
                build_dir = tostring(Path:new('{cwd}', 'build', '{os}-{build_type}')),         -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
                -- samples_path = tostring(script_path:parent():parent():parent() / 'samples'), -- Folder with samples. `samples` folder from the plugin directory is used by default.
                default_projects_path = tostring(Path:new(vim.loop.os_homedir(), 'Projects')), -- Default folder for creating project.
                configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' },                  -- Default arguments that will be always passed at cmake configure step. By default tells cmake to generate `compile_commands.json`.
                build_args = { "-j", "8" },                                                    -- Default arguments that will be always passed at cmake build step.
                on_build_output = nil,                                                         -- Callback that will be called each time data is received by the current process. Accepts the received data as an argument.
                quickfix = {
                    pos = 'botright',                                                          -- Where to open quickfix
                    height = 15,                                                               -- Height of the opened quickfix.
                    only_on_error = false,                                                     -- Open quickfix window only if target build failed.
                },
                copy_compile_commands = true,                                                  -- Copy compile_commands.json to current working directory.
                dap_configurations = {
                    -- Table of different DAP configurations.
                    codelldb = { type = 'codelldb', request = 'launch' },
                    lldb_vscode = { type = 'codelldb', request = 'launch' },
                    cppdbg_vscode = { type = 'cppdbg', request = 'launch' },
                },
                dap_configuration = 'codelldb', -- DAP configuration to use if the projects `parameters_file` does not specify one.
                dap_open_command = false,       -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
            })
        end,
        event = "BufReadPost",
    }
}
