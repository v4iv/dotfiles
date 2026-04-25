return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = "nvim-tree/nvim-web-devicons",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			local nvimtree = require("nvim-tree")

			-- recommended settings from nvim-tree documentation
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			-- optionally enable 24-bit colour
			vim.opt.termguicolors = true

			nvimtree.setup({
				filters = { dotfiles = false, custom = { ".DS_Store" } },
				disable_netrw = true,
				hijack_cursor = true,
				sync_root_with_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = false,
				},
				view = {
					width = 30,
					preserve_window_proportions = true,
				},
				renderer = {
					root_folder_label = false,
					highlight_git = true,
					indent_markers = { enable = true },
					icons = {
						glyphs = {
							default = "󰈚",
							folder = {
								default = "",
								empty = "",
								empty_open = "",
								open = "",
								symlink = "",
							},
							git = { unmerged = "" },
						},
					},
				},
			})
			local map = vim.keymap.set

			map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
			map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree window toggle" })
		end,
	},
}
