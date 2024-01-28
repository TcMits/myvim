local lsp = require("lsp-zero")

local servers = {
  "gopls",
  "cssls",
  "html",
  "tsserver",
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
}

lsp.preset("recommended")

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


lsp.configure("tsserver", {
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

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
  ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
  ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
  ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
  ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  ["<C-e>"] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }),
  -- Accept currently selected item. If none selected, `select` first item.
  -- Set `select` to `false` to only confirm explicitly selected items.
  ["<CR>"] = cmp.mapping.confirm({ select = true }),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expandable() then
      luasnip.expand()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif check_backspace() then
      fallback()
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
  sources = {
    -- Copilot Source
    { name = "copilot",  group_index = 2 },
    -- Other Sources
    { name = "nvim_lsp", group_index = 2 },
    { name = "path",     group_index = 2 },
    { name = "luasnip",  group_index = 2 },
  },
})

lsp.set_preferences({
  suggest_lsp_servers = true,
  sign_icons = {
    error = "E",
    warn = "W",
    hint = "H",
    info = "I",
  },
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  if client.name == "eslint" then
    vim.cmd.LspStop("eslint")
    return
  end

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
    ['tsserver'] = { 'javascript', 'typescript' },
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
