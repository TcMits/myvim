return {
	{
		"huggingface/llm.nvim",
		opts = {
			backend = "ollama",
			model = "codellama:7b",
			url = "http://localhost:11434/api/generate", -- llm-ls uses "/api/generate"
			lsp = {
				bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
			},
			accept_keymap = "<C-y>",
			dismiss_keymap = "<C-n>",
			tokenizer = {
				repository = "meta-llama/CodeLlama-7b-hf",
			},
		},
	},
}
