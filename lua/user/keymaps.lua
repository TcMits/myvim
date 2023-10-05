-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- vertical motions
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- format
keymap("n", "=", ":LspZeroFormat<CR>", opts)
keymap("v", "=", ":LspZeroFormat<CR>", opts)

-- Copilot
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""


-- Debug
keymap('n', '<leader>db', ":lua require 'dap'.toggle_breakpoint()<CR>")
keymap('n', '<leader>dB',
  ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
keymap({ 'n', 't' }, '<leader>dk', ":lua require 'dap'.step_out()<CR>")
keymap({ 'n', 't' }, "<leader>dl", ":lua require 'dap'.step_into()<CR>")
keymap({ 'n', 't' }, '<leader>dj', ":lua require 'dap'.step_over()<CR>")
keymap({ 'n', 't' }, '<leader>dh', ":lua require 'dap'.continue()<CR>")
keymap('n', '<leader>dn', ":lua require 'dap'.run_to_cursor()<CR>")
keymap('n', '<leader>dc', ":lua require 'dap'.terminate()<CR>")
keymap('n', '<leader>dR', ":lua require 'dap'.clear_breakpoints()<CR>")
keymap('n', '<leader>de', ":lua require 'dap'.set_exception_breakpoints({ 'all' })<CR>")
keymap('n', '<leader>da', ":lua require 'debugHelper'.attach()<CR>")
keymap('n', '<leader>dA', ":lua require 'debugHelper'.attachToRemote()<CR>")
keymap('n', '<leader>di', ":lua require 'dap.ui.widgets'.hover()<CR>")
keymap('n', '<leader>d?', function()
  local widgets = require "dap.ui.widgets";
  widgets.centered_float(widgets.scopes)
end)
keymap('n', '<leader>dK', ':lua require"dap".up()<CR>zz')
keymap('n', '<leader>dJ', ':lua require"dap".down()<CR>zz')
keymap('n', '<leader>dr',
  ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
keymap('n', '<leader>du', ':lua require"dapui".toggle()<CR>')
