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
  { "kyazdani42/nvim-web-devicons" },
  { 'nvim-tree/nvim-tree.lua', dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
  { "moll/vim-bbye" },
  { "nvim-lualine/lualine.nvim", dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { "lewis6991/impatient.nvim" },
  { "TimUntersberger/neogit", dependencies = "nvim-lua/plenary.nvim" },
  { "kamykn/spelunker.vim" },
  { "terryma/vim-multiple-cursors" },

  -- Copilot
  { "github/copilot.vim" },

  -- Indentation
  { "lukas-reineke/indent-blankline.nvim" },

  -- Debug
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },
  { "ravenxrz/DAPInstall.nvim" },

  -- Colorschemes
  {
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
  },
  { "tinted-theming/base16-vim" },

  {
    "VonHeikemen/lsp-zero.nvim",
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

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
  },

  -- Telescope
  { "nvim-telescope/telescope.nvim" },

  -- Treesitter
  { "vrischmann/tree-sitter-templ" },
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },

  -- Git
  { "lewis6991/gitsigns.nvim" },
})
