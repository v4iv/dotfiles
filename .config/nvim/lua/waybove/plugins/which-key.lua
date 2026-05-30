return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		cmd = "WhichKey",
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
			"<c-w>",
			'"',
			"'",
			"`",
			"c",
			"v",
			"g",
			"\\",
		},
		dependencies = {
			{ "nvim-mini/mini.icons", version = false, lazy = true },
		},
		config = function()
			local map = vim.keymap.set

			map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

			map("n", "<leader>wk", function()
				vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
			end, { desc = "whichkey query lookup" })

			require("which-key").setup({
				preset = "helix",
			})
		end,
	},
}
