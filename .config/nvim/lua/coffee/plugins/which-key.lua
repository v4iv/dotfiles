return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		cmd = "WhichKey",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
		config = function()
			require("which-key").setup({
				preset = "helix",
				plugins = {
					marks = true, -- shows a list of your marks on ' and `
					registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
					-- the presets plugin, adds help for a bunch of default keybindings in Neovim
					-- No actual key bindings are created
					spelling = {
						enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
						suggestions = 20, -- how many suggestions should be shown in the list?
					},
					presets = {
						operators = true, -- adds help for operators like c, d, y, ...
						motions = true, -- adds help for motions
						text_objects = true, -- help for text objects triggered after entering an operator
						windows = true, -- default bindings on <c-w>
						nav = true, -- misc bindings to work with windows
						z = true, -- bindings for folds, spelling and others prefixed with z
						v = true,
						g = true, -- bindings for prefixed with g
					},
				},
			})

			local map = vim.keymap.set

			map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "WhichKey All Keymaps" })

			map("n", "<leader>wk", function()
				vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
			end, { desc = "WhichKey Query Lookup" })
		end,
		---@param ctx { mode: string, operator: string }
		defer = function(ctx)
			if vim.list_contains({ "d", "y" }, ctx.operator) then
				return true
			end
			return vim.list_contains({ "<C-V>", "V" }, ctx.mode)
		end,
	},
}
