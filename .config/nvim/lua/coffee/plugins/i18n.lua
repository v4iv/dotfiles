return {
	{
		"yelog/i18n.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			-- optional pickers:
			-- "folke/snacks.nvim",
			-- 'ibhagwan/fzf-lua',
			-- 'nvim-telescope/telescope.nvim',
		},
		config = function()
			require("i18n").setup({
				auto_detect = {
					enabled = true,
					root_dirs = { "src", "app" }, -- directories to scan
					locale_dir_names = { "locales", "messages", "i18n" }, -- locale directory names
					extensions = { "json", "ts" }, -- supported file extensions
					max_depth = 6, -- max directory depth to scan
					notify = true, -- show auto-detect summary
				},
				-- locales will also be auto-detected if not specified
				i18n_keys = {
					popup_type = "snacks",
				},
			})
		end,
	},
}
