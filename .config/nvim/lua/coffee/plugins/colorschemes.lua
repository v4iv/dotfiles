return {
	"devbydaniel/houston.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = false,
		italic_comments = true,
		on_colors = function(c)
			c.bg = "#342A57"
			c.bg_panel = "#3F3467" -- swapped to keep panel darker than float
			c.bg_float = "#4F427D"
		end,
		on_highlights = function(hl, c)
			-- Legacy & standard syntax groups
			hl.Keyword = { italic = true }
			hl.Conditional = { italic = true }
			hl.Type = { italic = true }

			-- Treesitter capture groups (@-prefixed)
			hl["@keyword"] = { italic = true }
			hl["@keyword.conditional"] = { italic = true }
			hl["@type"] = { italic = true }
			hl["@type.builtin"] = { italic = true }
		end,
	},
}
