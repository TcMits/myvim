return {
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				transparent = true,
			})

			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
		branch = "main",
		config = function()
			require("nvim-treesitter")
				.install({
					"c",
					"query",
					"markdown",
					"markdown_inline",
					"rust",
					"bash",
					"lua",
					"python",
					"toml",
					"yaml",
					"json",
					"html",
					"css",
					"javascript",
					"typescript",
					"tsx",
					"cpp",
					"cmake",
					"go",
					"java",
					"latex",
					"regex",
					"make",
					"templ",
					"vim",
					"vimdoc",
					"astro",
				})
				:wait(300000)

			-- Enable syntax highlighting
			vim.cmd("syntax on")
		end,
	},
}
