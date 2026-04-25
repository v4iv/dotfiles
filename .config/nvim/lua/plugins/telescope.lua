return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- optional but recommended
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
			"folke/todo-comments.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
			local transform_mod = require("telescope.actions.mt").transform_mod
			local map = vim.keymap.set

			local trouble = require("trouble")
			local trouble_telescope = require("trouble.sources.telescope")

			-- or create your custom action
			local custom_actions = transform_mod({
				open_trouble_qflist = function(prompt_buffr)
					trouble.toggle("quickfix")
				end,
			})

			telescope.setup({
				defaults = {
					path_display = { "smart" },
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous, -- move to prev result
							["<C-j>"] = actions.move_selection_next, -- move to next result
							["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
							["<C-t>"] = trouble_telescope.open,
						},
					},
				},
			})

			telescope.load_extension("fzf")

			map("n", "<leader>ff", function()
				builtin.find_files({
					hidden = true,
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--glob",
						"!**/.git/*",
					},
				})
			end, { desc = "telescope find files (dotfiles, no .git)" })
			map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "telescope fuzzy live grep" })
			map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
			map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "telescope fuzzy find recent files" })
			map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
			map(
				"n",
				"<leader>fz",
				"<cmd>Telescope current_buffer_fuzzy_find<CR>",
				{ desc = "telescope find in current buffer" }
			)
			map(
				"n",
				"<leader>fa",
				"<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
				{ desc = "telescope find all files" }
			)
			map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "telescope find todos" })
			map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
			map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
			map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
			map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "telescope find keymaps" })
		end,
	},
}
