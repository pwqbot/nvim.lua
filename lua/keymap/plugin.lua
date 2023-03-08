local function map(mode, shortcut, command)
    vim.keymap.set(mode, shortcut, command, { silent = true })
end

--- file tree ---
map({ 't', 'n', 'i' }, '<F1>', '<cmd>NvimTreeFindFileToggle<CR>')
map('n', ']h', '<CMD>Gitsigns next_hunk<CR>')
map('n', '[h', '<CMD>Gitsigns prev_hunk<CR>')
--- comment ---
map('n', '<leader>td', "<cmd>TodoTelescope<CR>")
map('n', ']h', '<CMD>Gitsigns next_hunk<CR>')
map('n', '[h', '<CMD>Gitsigns prev_hunk<CR>')

map("n", "<C-g>", "<cmd>LazyGit<cr>")

--- trouble ---
map('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<cr>')
map('n', '<leader>sg', '<cmd>Gitsigns stage_hunk<cr>')
map('n', '<leader>usg', '<cmd>Gitsigns undo_stage_hunk<cr>')
map('n', '<leader>gd', '<cmd>Gitsigns diffthis<cr>')

--- emacs like ---
local readline = require 'readline'
map({ 'n', 'v' }, '<M-f>', readline.forward_word)

map({ 'n', 'v' }, '<M-b>', readline.backward_word)
-- map('!', '<C-a>', '<C-o>^')
map('i', '<C-e>', readline.end_of_line)
map('i', '<C-u>', readline.backward_kill_line)
map('i', '<C-F>', '<Right>')
map('i', '<C-B>', '<Left>')


map('n', '<F4>', '<cmd>AsyncTask project-test<cr>')
map('n', '<F5>', '<cmd>AsyncTask project-run<cr>')
map('n', '<F6>', '<cmd>AsyncTask project-build<cr>')
map('n', '<F7>', '<cmd>AsyncTask project-init<cr>')
map('n', '<leader>cp', '<cmd>CopilotPanel<cr>')
map("n", "<C-a>", require("dial.map").inc_normal())
map("n", "<C-x>", require("dial.map").dec_normal())
map("v", "<C-a>", require("dial.map").inc_visual())
map("v", "<C-x>", require("dial.map").dec_visual())
map("v", "g<C-a>", require("dial.map").inc_gvisual())
map("v", "g<C-x>", require("dial.map").dec_gvisual())
map('n', '<leader>wm', '<cmd>WindowsMaximize<cr>')
map('n', '<leader>1', '<Plug>SlimeParagraphSend')
map('x', '<leader>1', '<cmd>SlimeSend<cr>')


map({ "n", "t", "i" }, "<A-u>", function() require "dap".step_out() end)
map({ "n", "t", "i" }, "<A-i>", function() require "dap".step_into() end)
map({ "n", "t", "i" }, "<A-o>", function() require "dap".step_over() end)
map({ "n", "t", "i" }, "<A-v>", function() require("dap.ui.widgets").hover() end)
map({ "n", "t", "i" }, "<A-p>", function() require("dap").up() end)
map({ "n", "t", "i" }, "<A-d>", function() require("dap").down() end)
map("n", "<leader>cc", "<cmd>CMake configure<cr>")
map("n", "<leader>ct", "<cmd>CMake select_target<cr>")
map("n", "<leader>cb", "<cmd>CMake build<cr>")
map("n", "<leader>cd", "<cmd>CMake build_and_debug<cr>")
map("n", "<leader>cr", "<cmd>CMake build_and_run<cr>")

map("n", "<leader>db", "<cmd>Telescope dap list_breakpoints<CR>")
map("n", "<leader>df", "<cmd>Telescope dap frames<CR>")
map("n", "<leader>dc", function() require("dap").clear_breakpoints() end)
map("n", "<F7>", function() require "dap".toggle_breakpoint() end)
map({ "n", "t" }, "<F8>", function() require "dap".continue() end)
map({ "n", "t" }, "<F9>", function() require "dap".terminate() end)
