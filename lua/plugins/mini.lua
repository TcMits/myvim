return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.icons").setup({ style = 'ascii' })

      require('mini.statusline').setup()

      require('mini.comment').setup({
        mappings = {
          comment = '<leader>/',
          comment_visual = '<leader>/',
        },
      })

      require('mini.bufremove').setup()
      vim.keymap.set("n", "<S-q>", ":bdelete<CR>", { silent = true })
    end
  },
}
