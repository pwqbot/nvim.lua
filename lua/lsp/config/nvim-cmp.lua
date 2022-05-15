local cmp = require'cmp'
local luasnip = require'luasnip'
local kind_icons = {
    Class = " ",
    Color = " ",
    Constant = "C ",
    Constructor = " ",
    Enum = "練",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = "",
    Folder = " ",
    Function = " ",
    Interface = "ﰮ ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Operator = "",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = "塞",
    Value = " ",
    Variable = " ",
}

local source_names = {
    nvim_lsp = "(LSP)",
    emoji = "(Emoji)",
    path = "(Path)",
    luasnip = "(Snippet)",
    buffer = "(Buffer)",
}

cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 'c'}),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 'c'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, 
        -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp', max_item_count = 5 },
        { name = 'luasnip' }, 
        { name = 'buffer', max_item_count = 5 },
        { name = 'path', max_item_count = 3 },
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, 
        {
            { name = 'buffer' , max_item_count = 5},
            { name = 'path', max_item_count = 3 },
        }),
    completion = {
        keyword_length = 1,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    formatting = {
        format = function(entry, vim_item)
            -- local max_width = lvim.builtin.cmp.formatting.max_width
            -- if max_width ~= 0 and #vim_item.abbr > max_width then
            --     vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. "…"
            -- end
            vim_item.kind = kind_icons[vim_item.kind]
            vim_item.menu = source_names[entry.source.name]
            -- vim_item.dup = lvim.builtin.cmp.formatting.duplicates[entry.source.name]
            -- or lvim.builtin.cmp.formatting.duplicates_default
            return vim_item
        end,
    },
    experimental = {
        ghost_text = false,
    }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer', max_item_count = 10 }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' , max_item_count = 10},
        { name = 'cmdline', max_item_count = 10}
    })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- require('lspconfig')['clangd'].setup {
--     capabilities = capabilities
-- }
--
-- require('lspconfig')['pyright'].setup {
--     capabilities = capabilities
-- }
--
-- require('lspconfig')['gopls'].setup {
--     capabilities = capabilities
-- }
