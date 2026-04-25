return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	config = function()
		-- Disable automatic previews.
		require("markview").setup({
			preview = { enable = false },
		})

		vim.api.nvim_set_keymap(
			"n",
			"<leader>mv",
			"<CMD>Markview<CR>",
			{ desc = "Toggles `markview` previews globally." }
		)
	end,
	-- Completion for `blink.cmp`
	-- dependencies = { "saghen/blink.cmp" },
}
