return {
  {
    "TimUntersberger/neogit",
    config = function()
      require("neogit").setup({})
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  { "sindrets/diffview.nvim" },
}
