return {
	{
		"devbydaniel/houston.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("houston").setup({
				transparent = false,
				italic_comments = true,
				terminal_colors = true, -- set vim.g.terminal_color_*
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					keywords = { "italic" },
					conditionals = { "italic" },
					functions = {},
					variables = {},
					booleans = {},
					types = {},
				},
				-- Mutate the palette before highlights are built
				on_colors = function(c) end,
				-- Mutate highlight groups before they're applied
				on_highlights = function(hl, c) end,
			})
		end,
	},
}
