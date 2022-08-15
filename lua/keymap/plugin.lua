local function map(mode, shortcut, command)
    vim.keymap.set(mode, shortcut, command, { silent = true })
end

--- file tree ---
map({ 't', 'n', 'i' }, '<F1>', '<cmd>NvimTreeFindFileToggle<CR>')

--- fuzzf finder ---
local tele = require('telescope.builtin')

map('n', '<F3>', function() require 'telescope'.extensions.project.project {} end)
map('n', '<F4>', function() tele.find_files { cwd = "~", hidden = true } end)
map('n', '<C-p>', function() tele.find_files { hidden = true } end)
map('n', '<C-b>', function() tele.buffers { sort_mru = true } end)
map('n', '<C-n>', function() tele.lsp_dynamic_workspace_symbols {} end)
map('n', '<C-f>', function() tele.lsp_document_symbols {} end)
map('n', '<leader>gp', function() tele.live_grep() end)
map('n', '<leader>fo', function() tele.oldfiles() end)
map('n', '<leader>m', function() require 'telescope'.extensions.vim_bookmarks.all() end)
--- comment ---
map('n', '<C-_>', '<CMD>lua require("Comment.api").toggle.line_wise.current()<CR>')
map('x', '<C-_>',
    '<ESC><CMD>lua require("Comment.api").toggle.line_wise(vim.fn.visualmode())<CR>'
)
map('n', '<leader>td', "<cmd>TodoTelescope<CR>")

--- quick motion ---
-- map('n', 'f', function() require 'hop'.hint_words({}) end)

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
})

local function _lazygit_toggle()
    lazygit:toggle()
end

map("n", "<C-g>", function() _lazygit_toggle() end)

map('n', '<leader>cr', "<cmd>CompetiTestRun<CR>")
map('n', '<leader>cg', "<cmd>CompetiTestReceive<CR>")


--- trouble ---
map('n', "<leader>fx", "<cmd>TroubleToggle<cr>")

map('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<cr>')
