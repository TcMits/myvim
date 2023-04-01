local colorscheme = "tender"

-- vim.g.neobones = { transparent_background = true }
vim.g.macvim_skip_colorscheme = 1

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	return
end

