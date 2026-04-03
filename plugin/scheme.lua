vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

require("kanagawa").setup({ transparent = true })
vim.cmd("colorscheme kanagawa-dragon")
require("ibl").setup()

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

local parser = {
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
	"sql",
	"svelte",
}

require("nvim-treesitter").install(parser):wait(300000)
vim.cmd("syntax on")
local filetypes = {}

for _, p in ipairs(parser) do
	local ft = vim.treesitter.language.get_filetypes(p)
	for _, v in ipairs(ft) do
		table.insert(filetypes, v)
	end
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = filetypes,
	callback = function()
		vim.treesitter.start()
	end,
})
