local bufferline = require("bufferline")
bufferline.setup({
  options = {
    close_command = "Bdelete! %d",       -- can be a string | function, see "Mouse actions"
    right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    separator_style = "thin",            -- | "thick" | "thin" | { 'any', 'any' },
  },
})
