return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- optional but recommended
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local builtin = require("telescope.builtin")
			local map = vim.keymap.set

			map("n", "<leader>ff", builtin.find_files, { desc = "telescope find files" })
			map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
			map(
				"n",
				"<leader>fz",
				"<cmd>Telescope current_buffer_fuzzy_find<CR>",
				{ desc = "telescope find in current buffer" }
			)
			map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
			map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
			map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
			map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
			map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
			map(
				"n",
				"<leader>fa",
				"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
				{ desc = "telescope find all files" }
			)

			-- Tree Sitter configurations
			require("nvim-treesitter").setup({
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
