return {
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"mason-org/mason.nvim",
				cmd = "Mason",
				keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
				build = ":MasonUpdate",
				opts_extend = { "ensure_installed" },
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
					ensure_installed = {
						"astro",
						"css_variables",
						"cssls",
						"denols",
						"emmet_ls",
						"eslint",
						"gopls",
						"graphql",
						"html",
						"lua_ls",
						"oxfmt",
						"oxlint",
						"prettier",
						"prismals",
						"pylsp",
						"pyright",
						"rust_analyzer",
						"shfmt",
						"stylua",
						"svelte",
						"tailwindcss",
						"vtsls",
						"vue_ls",
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			require("mason-lspconfig").setup({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
			})
		end,
	},
}
