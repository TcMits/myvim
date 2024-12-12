return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          -- vimgrep_arguments = {
          -- 	"rg",
          -- 	"--color=never",
          -- 	"--no-heading",
          -- 	"--with-filename",
          -- 	"--line-number",
          -- 	"--column",
          -- 	"--smart-case",
          -- 	"--no-ignore", -- **This is the added flag**
          -- 	"--hidden", -- **Also this flag. The combination of the two is the same as `-uu`**
          -- 	"-uu",
          -- },
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "smart" },
          file_ignore_patterns = { ".git/", "node_modules" },
          mappings = {
            i = {
              ["<Down>"] = actions.cycle_history_next,
              ["<Up>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
        },
      })

      vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
      vim.keymap.set("n", "<leader>ft", ":Telescope live_grep<CR>")
      vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>")
      vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
    end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    config = function()
      require("oil").setup({ columns = { "icon", "permissions", "size" } })

      vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  }
}
