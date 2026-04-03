vim.pack.add({
  "https://github.com/sindrets/diffview.nvim",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/lewis6991/gitsigns.nvim",
})

require("neogit").setup()
require("gitsigns").setup()
