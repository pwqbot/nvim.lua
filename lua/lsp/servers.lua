local M = {}

PYTHON_THING = "empty"

local function find_python_venv()
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
    local python_venv = find_python_venv()

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

local clangd = require("clangd_extensions").prepare {
    server = {
        cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
            "-compile-commands-dir=build",
            "--completion-style=detailed",
            "--clang-tidy",
            "--include-cleaner-stdlib",
            "--log=verbose",
            "--header-insertion=iwyu",
            "--header-insertion-decorators",
            "--pretty",
            "-j=4",
        },
    },

    extensions = {
        -- defaults:
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,
        -- These apply to the default ClangdSetInlayHints command
        inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",
            -- whether to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
            -- The highlight group priority for extmark
            priority = 100,
        },
        ast = {
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },

            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            },

            highlights = {
                detail = "Comment",
            },
        },
        memory_usage = {
            border = "none",
        },
        symbol_info = {
            border = "none",
        },
    },
}

M.servers = {
    clangd = clangd,
    pyright = {
        python = {
            venvPath = find_python_venv()
        }
    },
    volar = {},
    yamlls = {},
    bashls = {},
    rust_analyzer = {},
    -- pylsp = {
    --     settings = {
    --         pylsp = {
    --             plugins = get_pyls_plugins()
    --         }
    --     }
    -- },
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
    -- hls = {
    -- },
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
    },
    cmake = {},
}

return M
