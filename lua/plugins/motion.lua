return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Flash Treesitter Search",
            },
        },
    },
    {
        "rgroli/other.nvim",
        keys = {
            {
                "<C-]>",
                "<cmd>:Other test<CR>",
            },
        },
        config = function()
            require("other-nvim").setup({
                showMissingFiles = true,
                mappings = {
                    {
                        pattern = "/test/unit/(.*)/(.*)_test.cpp$",
                        target = "/include/*/%1/%2.hpp",
                        context = "test",
                    },
                    {
                        pattern = "/include/[a-zA-Z]*/(.*)/(.*).hpp$",
                        target = "/test/unit/%1/%2_test.cpp",
                        context = "test",
                    },
                    {
                        pattern = "/include/[a-zA-Z]*/(.*).hpp$",
                        target = "/test/unit/%1_test.cpp",
                        context = "test",
                    },
                    {
                        pattern = "/adapter/(.*)/(.*).hpp$",
                        target = "/test/%1/%2_test.cpp",
                        context = "test",
                    },
                    {
                        pattern = "/adapter/(.*).hpp$",
                        target = "/test/%1_test.cpp",
                        context = "test",
                    },
                }
            })
        end
    },
    {
        'linty-org/readline.nvim',
        keys = {
            { '<M-f>', function() require('readline').forward_word() end,  mode = { 'i' } },
            { '<M-b>', function() require('readline').backward_word() end, mode = { 'i' } },
            {
                '<C-a>',
                '<C-o>^',
                mode = 'i'
            },
            {
                '<C-e>',
                function()
                    require('readline').end_of_line()
                end,
                mode = 'i'
            },
            {
                '<C-k>',
                function()
                    require('readline').kill_line()
                end,
                mode = 'i'
            },
            {
                '<C-f>',
                '<Right>',
                mode = 'i'
            },
            {
                '<C-b>',
                '<Left>',
                mode = 'i'
            }

        }
    },
    {
        'chaoren/vim-wordmotion',
        config = function()
            vim.cmd [[ let g:wordmotion_spaces = '_-.' ]]
        end,
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' },
        event = "BufReadPost",
        config = function()
            vim.o.statuscolumn =
            '%=%l%s%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "▼" : "⏵") : " " }'
            vim.o.foldcolumn = '0' -- '0' is not bad
            vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
            vim.cmd [[hi Folded guifg=NONE guibg=NONE]]



            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = ('  %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'MoreMsg' })
                return newVirtText
            end

            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { 'treesitter', 'indent' }
                end,
                open_fold_hl_timeout = 0,
                -- fold_virt_text_handler = handler
            })
        end,
    }
}
