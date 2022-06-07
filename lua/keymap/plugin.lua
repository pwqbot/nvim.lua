local function map(mode, shortcut, command)
    vim.keymap.set(mode, shortcut, command, { silent = true })
end

--- file tree ---
map({ 't', 'n' }, '<F1>', '<cmd>NvimTreeFindFileToggle<CR>')

--- git ---
map('n', '<F2>', '<cmd>Neogit<CR>')

--- fuzzf finder ---
map('n', '<F3>', function() require('telescope').extensions.projects.projects {} end)
map('n', '<F4>', function() require('telescope.builtin').find_files { cwd = "~", hidden = true } end)
map('n', '<C-p>', function() require('telescope.builtin').find_files { hidden = true } end)
map('n', '<C-n>', function() require('telescope.builtin').buffers { sort_mru = true } end)
map('n', '<leader>fo', function() require('telescope.builtin').oldfiles() end)
map('n', '<leader>fg', function() require('telescope.builtin').grep_string() end)
map('n', '<leader>fs', function() require('telescope.builtin').lsp_document_symbols {} end)
map('n', '<leader>fa', function() require('telescope.builtin').lsp_dynamic_workspace_symbols {} end)

map('n', '<M-1>', '<Cmd>BufferLineGoToBuffer 1<CR>')
map('n', '<M-2>', '<Cmd>BufferLineGoToBuffer 2<CR>')
map('n', '<M-3>', '<Cmd>BufferLineGoToBuffer 3<CR>')
map('n', '<M-4>', '<Cmd>BufferLineGoToBuffer 4<CR>')
map('n', '<M-5>', '<Cmd>BufferLineGoToBuffer 5<CR>')
map('n', '<M-6>', '<Cmd>BufferLineGoToBuffer 6<CR>')
map('n', '<M-7>', '<Cmd>BufferLineGoToBuffer 7<CR>')

--- trouble ---
vim.keymap.set('n', "<leader>t", "<cmd>TroubleToggle<cr>", { noremap = true, silent = true })

--- comment ---
map('n', '<C-_>', require("Comment.api").toggle_current_linewise)
map('x', '<C-_>',
    '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>'
)

--- quick motion ---
map('n', 'f', function() require 'hop'.hint_words({}) end)
