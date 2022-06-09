local M = {}
-- Use a loop to conveniently call 'setup' on multiple servers and

PYTHON_THING = "empty"

function Find_python_venv()
    -- return the path to a currently activated python venv
    -- supports Conda, pyenv, pipenv
    if vim.env.CONDA_PREFIX ~= nil then
        PYTHON_THING = "conda"
        return vim.env.CONDA_PREFIX
    elseif vim.env.PYENV_VIRTUAL_ENV ~= nil then
        PYTHON_THING = "pyenv"
        return vim.env.PYENV_VIRTUAL_ENV
    else
        local pipe = io.popen("pipenv --venv 2> /dev/null")
        local line = pipe:read()
        pipe:close()
        if line ~= nil and line:find("^/home/") ~= nil then
            PYTHON_THING = "pipenv"
            return line
        else
            PYTHON_THING = "none"
            return ""
        end
    end
end

local function get_pyls_plugins()
    local pylsp_plugins = {}
    local python_venv = Find_python_venv()

    pylsp_plugins.pydocstyle = {
        enabled = true
    }

    if python_venv ~= "" then
        pylsp_plugins.jedi = {
            environment = python_venv
        }
    end
    return pylsp_plugins
end

M.servers = {
    clangd = {
        cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
            "-compile-commands-dir=build",
            "--clang-tidy",
        }
    },
    -- pyright = {},
    pylsp = {
        settings = {
            pylsp = {
                plugins = get_pyls_plugins()
            }
        }
    },
    html = {},
    gopls = {
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
                usePlaceholders = true,
            }
        }
    },
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    -- path = runtime_path,
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    }
}

return M
