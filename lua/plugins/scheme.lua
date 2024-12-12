return {
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require('kanagawa').setup({
        transparent = true,
      })

      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "query",
          "markdown",
          "markdown_inline",
          "rust",
          "bash",
          "lua",
          "python",
          "toml",
          "yaml",
          "json",
          "html",
          "css",
          "javascript",
          "typescript",
          "tsx",
          "cpp",
          "cmake",
          "go",
          "java",
          "latex",
          "regex",
          "make",
          "templ",
          "vim",
          "vimdoc",
        },               -- one of "all" or a list of languages
        highlight = {
          enable = true, -- false will disable the whole extension

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        sync_install = false,
        auto_install = true,
      })
    end,
  },
}
