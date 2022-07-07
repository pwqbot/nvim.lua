local function map(mode, shortcut, command)
    vim.keymap.set(mode, shortcut, command, { silent = true })
end

--- file tree ---
map({ 't', 'n', 'i' }, '<F1>', '<cmd>NvimTreeFindFileToggle<CR>')

--- git ---
map('n', '<F2>', '<cmd>Neogit<CR>')

local themes = require('telescope.themes')
local tele = require('telescope.builtin')

--- fuzzf finder ---
map('n', '<F3>', function() tele.extensions.projects.projects {} end)
map('n', '<F4>', function() tele.find_files { cwd = "~", hidden = true } end)
map('n', '<C-p>', function() tele.find_files { hidden = true } end)
map('n', '<C-b>', function() tele.buffers { sort_mru = true } end)
map('n', '<C-n>', function() tele.lsp_dynamic_workspace_symbols {} end)
map('n', '<C-f>', function() tele.lsp_document_symbols {} end)
map('n', '<leader>lg', function() tele.live_grep() end)
map('n', '<leader>fo', function() tele.oldfiles() end)
map('n', '<leader>df',
    function() tele.lsp_definitions({ jump_type = "never", ignore_filename = true, trim_text = true }) end)

--- trouble ---
vim.keymap.set('n', "<leader>t", "<cmd>TroubleToggle<cr>", { noremap = true, silent = true })

--- comment ---
map('n', '<C-_>', require("Comment.api").toggle_current_linewise)
map('x', '<C-_>',
    '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>'
)

--- quick motion ---
map('n', 'f', function() require 'hop'.hint_words({}) end)

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
})

function _lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

map('n', '<leader>cr', "<cmd>CompetiTestRun<CR>")
map('n', '<leader>cg', "<cmd>CompetiTestReceive<CR>")
