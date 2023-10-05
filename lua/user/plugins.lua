local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
  use({ "numToStr/Comment.nvim" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "kyazdani42/nvim-tree.lua" })
  use({ "akinsho/bufferline.nvim" })
  use({ "moll/vim-bbye" })
  use({ "nvim-lualine/lualine.nvim" })
  use({ "lewis6991/impatient.nvim" })
  use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
  use({ "kamykn/spelunker.vim" })
  use({ "terryma/vim-multiple-cursors" })

  -- Copilot
  use({ "github/copilot.vim" })

  -- Indentation
  use({ "lukas-reineke/indent-blankline.nvim" })

  -- Debug
  use({ "mfussenegger/nvim-dap" })
  use({ "rcarriga/nvim-dap-ui" })
  use({ "ravenxrz/DAPInstall.nvim" })

  -- Colorschemes
  use({
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    requires = "rktjmp/lush.nvim",
  })
  use({ "tinted-theming/base16-vim" })

  use({
    "VonHeikemen/lsp-zero.nvim",
    requires = {
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
  })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
