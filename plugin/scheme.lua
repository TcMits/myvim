vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

require("kanagawa").setup({ transparent = true })
vim.cmd("colorscheme kanagawa-dragon")

local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup({ indent = { highlight = highlight } })

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
