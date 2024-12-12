local servers = {
  "gopls",
  "cssls",
  "html",
  "ts_ls",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "eslint",
  "lua_ls",
  "ruff",
  "cmake",
  "templ",
  "tailwindcss",
  "rust_analyzer",
  "tsp_server",
}

return {
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
      { "zbirenbaum/copilot.lua" },
      { "zbirenbaum/copilot-cmp" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
    config = function()
      vim.diagnostic.config({ virtual_text = true })


      -- copilot
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
      require('copilot_cmp').setup()

      -- install servers
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = servers,
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        },
      })

      local lsp = require("lsp-zero")

      lsp.configure("pyright", {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              typeCheckingMode = "off",
              useLibraryCodeForTypes = true,
              diagnosticMode = 'openFilesOnly',
            },
          },
        },
      })

      lsp.configure("yamlls", {
        settings = {
          yaml = {
            keyOrdering = false
          }
        }
      })


      lsp.configure("rust_analyzer", {
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              disabled = { "unresolved-proc-macro" },
            }
          }
        }
      })


      lsp.configure("ts_ls", {
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
      })


      lsp.configure("tailwindcss", {
        filetypes = {
          'templ'
        },
        init_options = {
          userLanguages = {
            templ = "html"
          }
        }
      })


      lsp.configure("gopls", {
        settings = {
          gopls = {
            gofumpt = true
          }
        }
      })

      lsp.configure("clangd", {
        filetypes = { "c", "cpp", "objc", "objcpp" },
      })

      -- auto completions
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local cmp_format = lsp.cmp_format({ details = true })
      local cmp_mappings = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      })

      cmp.setup({
        mapping = cmp_mappings,
        formatting = cmp_format,
        sources = {
          -- Copilot Source
          { name = "copilot",  group_index = 2 },
          -- Other Sources
          { name = "nvim_lsp", group_index = 2 },
          { name = "path",     group_index = 2 },
          { name = "luasnip",  group_index = 2 },
        },
      })

      lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        local keymap = vim.keymap.set

        keymap("n", "gd", vim.lsp.buf.definition, opts)
        keymap("n", "K", vim.lsp.buf.hover, opts)
        keymap("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        keymap("n", "gl", vim.diagnostic.open_float, opts)
        keymap("n", "<leader>lj", vim.diagnostic.goto_next, opts)
        keymap("n", "<leader>lk", vim.diagnostic.goto_prev, opts)
        keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)
        keymap("n", "gr", vim.lsp.buf.references, opts)
        keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
        keymap("i", "<C-h>", vim.lsp.buf.signature_help, opts)
      end)

      lsp.format_mapping('=', {
        format_opts = {
          async = true,
          timeout_ms = 10000,
        },
        servers = {
          ['ts_ls'] = { 'javascript', 'typescript' },
          ['rust_analyzer'] = { 'rust' },
          ['ruff'] = { 'python' },
          ['lua_ls'] = { 'lua' },
          ['gopls'] = { 'go' },
          ['pyright'] = { 'python' },
          ['bashls'] = { 'bash' },
          ['jsonls'] = { 'json' },
          ['yamlls'] = { 'yaml' },
          ['html'] = { 'html' },
          ['cssls'] = { 'css' },
          ['cmake'] = { 'cmake' },
          ['templ'] = { 'templ' },
          ['tailwindcss'] = { 'html', 'css' },
          ['tsp_server'] = { 'typespec' },
        }
      })

      lsp.setup()
    end,
  },
}
