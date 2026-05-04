vim.pack.add({
	"https://github.com/hedyhli/outline.nvim",
})

require("outline").setup({
	outline_window = {
		auto_width = {
			-- Dynamically resize window width to fit content
			enabled = true,
			-- Maximum width (columns or percent if relative_width)
			max_width = 30,
			-- Include symbol details in width calculation
			include_symbol_details = false,
		},
	},
})
vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
