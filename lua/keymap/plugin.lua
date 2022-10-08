local function map(mode, shortcut, command)
    vim.keymap.set(mode, shortcut, command, { silent = true })
end

--- file tree ---
map({ 't', 'n', 'i' }, '<F1>', '<cmd>NvimTreeFindFileToggle<CR>')

--- fuzzf finder ---
local tele = require('telescope.builtin')

map('n', ']h', '<CMD>Gitsigns next_hunk<CR>')
map('n', '[h', '<CMD>Gitsigns prev_hunk<CR>')
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
map('n', '<leader>td', "<cmd>TodoTelescope<CR>")

map("n", "<C-g>", "<cmd>LazyGit<cr>")

map('n', '<leader>cr', "<cmd>CompetiTestRun<CR>")
map('n', '<leader>cg', "<cmd>CompetiTestReceive<CR>")


--- trouble ---
map('n', "<leader>tb", "<cmd>TroubleToggle<cr>")


map('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<cr>')
map('n', '<leader>sg', '<cmd>Gitsigns stage_hunk<cr>')
map('n', '<leader>usg', '<cmd>Gitsigns undo_stage_hunk<cr>')
map('n', '<leader>gd', '<cmd>Gitsigns diffthis<cr>')
local readline = require 'readline'
map('!', '<M-f>', readline.forward_word)
map('!', '<M-b>', readline.backward_word)
-- map('!', '<C-a>', '<C-o>^')
map('!', '<C-e>', readline.end_of_line)
map('!', '<C-k>', '<Up>')
map('!', '<C-j>', '<Down>')
map('!', '<C-u>', readline.backward_kill_line)
map('n', '<C-w>z', '<Cmd>WindowsMaximize<CR>')

--- emacs like ---
map('i', '<C-F>', '<Right>')
map('i', '<C-B>', '<Left>')

map('n', '<F4>', '<cmd>AsyncTask project-test<cr>')
map('n', '<F5>', '<cmd>AsyncTask project-run<cr>')
map('n', '<F6>', '<cmd>AsyncTask project-build<cr>')
map('n', '<F7>', '<cmd>AsyncTask file-build file-run<cr>')
map('n', '<leader>ts', function() require('telescope').extensions.asynctasks.all() end)
vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
