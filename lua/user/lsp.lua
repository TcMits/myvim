local lsp = require("lsp-zero")

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
  "ruff_lsp",
  "cmake",
  "templ",
  "tailwindcss",
  "bufls",
  "rust_analyzer",
}


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

-- keyOrdering is so annoying
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

local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_format = lsp.cmp_format({details = true})

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
    ['ruff_lsp'] = { 'python' },
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
    ['bufls'] = { 'proto' },
  }
})


require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = servers,
  handlers = {
    lsp.default_setup,
  },
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
})
