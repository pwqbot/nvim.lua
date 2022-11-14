local local_packer = function()
    local user_path = vim.fn.expand('~')

    Nvim_path = user_path .. [[/.config/nvim/]]
    local packer_start_path = Nvim_path .. 'pack/packer/start'
    local packer_path = packer_start_path .. '/packer.nvim'
    local packer_bootstrap
    if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
        print("install packer")
        packer_bootstrap = vim.fn.system({
            'git', 'clone', '--depth', '1',
            'https://github.com/wbthomason/packer.nvim', packer_path
        })
    end
    vim.opt.runtimepath:append(packer_start_path .. '/*')
end


local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require('packer').init({
    -- package_root = Nvim_path .. 'pack/',
    profile = {
        enable = true,
        threshold = 0,
    },
    display = {
        open_fn = function()
            return require("packer.util").float { border = 'rounded' }
        end,
    },
    auto_reload_compile = true,
})

local plugins = require("plugins/configs")

local convert_to_packer_format = function(plugins)
    local final_table = {}

    for key, val in pairs(plugins) do
        if val and type(val) == "table" then
            plugins[key] = val.rm_default_opts and user_plugins[key] or plugins[key]
            plugins[key][1] = key
            final_table[#final_table + 1] = plugins[key]
        end
    end

    return final_table
end

require('packer').startup { convert_to_packer_format(plugins) }


if packer_bootstrap then
    require('packer').sync()
end
