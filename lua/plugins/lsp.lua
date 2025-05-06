local servers = {
	"gopls",
	"cssls",
	"html",
	"ts_ls",
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
	"pyright",
}

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- LSP Support
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "zbirenbaum/copilot.lua" },
			{ "zbirenbaum/copilot-cmp" },

			-- Formatter
			{ "stevearc/conform.nvim" },
			{ "zapling/mason-conform.nvim" },
		},
		config = function()
			vim.diagnostic.config({ virtual_text = true })
			local util = require("lspconfig.util")
			local python_root_dir = function(fname)
				return util.root_pattern(
					"pyproject.toml",
					"ruff.toml",
					".ruff.toml",
					"setup.py",
					"setup.cfg",
					"requirements.txt",
					"Pipfile",
					"pyrightconfig.json",
					".git"
				)(fname) or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
			end

			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
			local server_lsp_configs = {
				ruff = {
					capabilities = lsp_capabilities,
					root_dir = python_root_dir,
				},
				pyright = {
					capabilities = lsp_capabilities,
					root_dir = python_root_dir,
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								typeCheckingMode = "off",
								useLibraryCodeForTypes = true,
								diagnosticMode = "openFilesOnly",
							},
						},
					},
				},
				yamlls = {
					capabilities = lsp_capabilities,
					settings = {
						yaml = {
							keyOrdering = false,
						},
					},
				},
				rust_analyzer = {
					capabilities = lsp_capabilities,
					settings = {
						["rust-analyzer"] = {
							diagnostics = {
								disabled = { "unresolved-proc-macro" },
							},
						},
					},
				},
				ts_ls = {
					capabilities = lsp_capabilities,
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
				},
				tailwindcss = {
					capabilities = lsp_capabilities,
					filetypes = {
						"templ",
					},
					init_options = {
						userLanguages = {
							templ = "html",
						},
					},
				},
				gopls = {
					capabilities = lsp_capabilities,
					settings = {
						gopls = {
							gofumpt = true,
						},
					},
				},
				clangd = {
					capabilities = lsp_capabilities,
					filetypes = { "c", "cpp", "objc", "objcpp" },
				},
				lua_ls = {
					capabilities = lsp_capabilities,
					settings = {
						Lua = {
							runtime = {
								version = "LuaJIT",
							},
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								library = {
									vim.env.VIMRUNTIME,
								},
							},
						},
					},
				},
			}

			-- copilot
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
			require("copilot_cmp").setup()

			-- install servers
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				handlers = {
					function(server_name)
						require("lspconfig")[server_name].setup(server_lsp_configs[server_name] or {
							capabilities = lsp_capabilities,
						})
					end,
				},
			})

			-- auto completions
			local cmp = require("cmp")
			local cmp_mappings = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Replace })
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
					{ name = "copilot", group_index = 2 },
					{ name = "nvim_lsp", group_index = 2 },
					{ name = "buffer", group_index = 2 },
					{ name = "path", group_index = 2 },
				},
			})

			local keymap = vim.keymap.set
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "ruff" },
					templ = { "templ" },
					sql = { "sleek" },
				},
				default_format_opts = {
					lsp_format = "fallback",
				},
			})
			require("mason-conform").setup({})

			keymap("n", "=", function()
				conform.format({ async = true })
			end, { desc = "Format code" })

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf, remap = false }

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
				end,
			})
		end,
	},
}
