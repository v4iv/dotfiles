return {
	"devbydaniel/houston.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = false,
		italic_comments = true,
		styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
			keyword = { italic = true },
			conditionals = { italic = true },
			types = { italic = true },
			functions = {},
			variables = {},
			booleans = {},
		},
	},
}
