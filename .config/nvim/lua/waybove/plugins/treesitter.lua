return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		lazy = false,
		build = ":TSUpdate",
		config = function()
			-- import nvim-treesitter plugin
			local treesitter = require("nvim-treesitter")
			treesitter.setup({
				highlight = { enable = true },
				indent = { enable = true },
			})

			-- use bash parser for zsh files
			vim.treesitter.language.register("bash", "zsh")
		end,
	},
}
