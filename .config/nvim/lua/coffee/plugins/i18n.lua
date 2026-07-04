return {
	{
		"strehk/lazy-watson",
		ft = { "javascript", "typescript", "svelte", "javascriptreact", "typescriptreact" },
		opts = {},
		keys = {
			{
				"<leader>wt",
				function()
					require("lazy-watson").toggle()
				end,
				desc = "Toggle Watson Preview",
			},
			{
				"<leader>wl",
				function()
					require("lazy-watson").select_locale()
				end,
				desc = "Select Locale",
			},
			{
				"<leader>wr",
				function()
					require("lazy-watson").refresh()
				end,
				desc = "Refresh Translations",
			},
			{
				"<leader>wh",
				function()
					require("lazy-watson").show_hover()
				end,
				desc = "Show Hover Preview",
			},
		},
	},
}
