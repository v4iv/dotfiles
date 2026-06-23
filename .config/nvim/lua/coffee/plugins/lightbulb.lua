return {
	{
		"kosayoda/nvim-lightbulb",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-lightbulb").setup({
				autocmd = { enabled = true },
			})
		end,
	},
}
