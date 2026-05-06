return {
	{
		"devbydaniel/houston.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("houston").setup({
				transparent = false,
				italic_comments = true,
			})
			vim.cmd.colorscheme("houston")
		end,
	},
}
