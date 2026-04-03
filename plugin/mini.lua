vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.nvim.git", version = vim.version.range('*') },
})

require("mini.icons").setup({ style = "ascii" })

require("mini.statusline").setup()

require("mini.comment").setup({
  mappings = {
    comment = "<leader>/",
    comment_visual = "<leader>/",
  },
})

require("mini.bufremove").setup()
vim.keymap.set("n", "<S-q>", ":bdelete<CR>", { silent = true })
