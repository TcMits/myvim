vim.pack.add({
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/stevearc/oil.nvim",
})

local telescope = require("telescope")
local actions = require("telescope.actions")
telescope.setup({
	defaults = {
		-- vimgrep_arguments = {
		-- 	"rg",
		-- 	"--color=never",
		-- 	"--no-heading",
		-- 	"--with-filename",
		-- 	"--line-number",
		-- 	"--column",
		-- 	"--smart-case",
		-- 	"--no-ignore", -- **This is the added flag**
		-- 	"--hidden", -- **Also this flag. The combination of the two is the same as `-uu`**
		-- 	"-uu",
		-- },
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },
		mappings = {
			i = {
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
})

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>ft", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>")
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")

require("oil").setup({
	columns = { "icon", "permissions", "size" },
	use_default_keymaps = false,
	keymaps = {
		["g?"] = { "actions.show_help", mode = "n" },
		["<CR>"] = "actions.select",
		["<C-p>"] = "actions.preview",
		["<C-c>"] = { "actions.close", mode = "n" },
		["<C-r>"] = "actions.refresh",
		["-"] = { "actions.parent", mode = "n" },
		["g."] = { "actions.toggle_hidden", mode = "n" },
	},
})
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
