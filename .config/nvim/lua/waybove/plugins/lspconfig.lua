return {
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- list of servers for mason to install
			ensure_installed = {
				"astro",
				"css_variables",
				"cssls",
				"emmet_ls",
				"eslint",
				"gopls",
				"graphql",
				"html",
				"lua_ls",
				"oxlint",
				"prismals",
				"pyright",
				"rust_analyzer",
				"svelte",
				"tailwindcss",
				"vtsls",
				"vue_ls",
			},
		},
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
						"oxfmt",
						"stylua",
						"prettier",
						"shfmt",
					},
				},
			},
			"neovim/nvim-lspconfig",
			"saghen/blink.cmp",
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
