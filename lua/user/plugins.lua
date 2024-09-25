local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- My plugins here
  { "numToStr/Comment.nvim" },
  { "moll/vim-bbye" },
  { "nvim-lualine/lualine.nvim",          dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { "TimUntersberger/neogit" },

  -- Indentation
  { "lukas-reineke/indent-blankline.nvim" },

  -- Colorschemes
  { "RRethy/base16-nvim" },
  { "xiyaowong/transparent.nvim" },

  -- spell
  { "kamykn/spelunker.vim" },

  -- lsp
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "zbirenbaum/copilot.lua" },
      { "zbirenbaum/copilot-cmp" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
  },

  -- Telescope
  { "nvim-telescope/telescope.nvim" },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },

  -- Git
  { "lewis6991/gitsigns.nvim" },
  { "sindrets/diffview.nvim" },
})
