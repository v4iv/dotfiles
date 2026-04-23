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
		},
		config = function()
			local map = vim.keymap.set

			map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

			map("n", "<leader>wk", function()
				vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
			end, { desc = "whichkey query lookup" })
		end,
	},
}
