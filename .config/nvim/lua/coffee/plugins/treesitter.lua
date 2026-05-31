return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
		cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
		opts_extend = { "ensure_installed" },
		opts = {
			-- LazyVim config for treesitter
			install_dir = vim.fn.stdpath("data") .. "/site",
			indent = { enable = true },
			highlight = {
				enable = true,

				disable = function(_, buf)
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						Snacks.notify.warn(
							"File larger than 100KB treesitter disabled for performance",
							{ title = "Treesitter" }
						)
						return true
					end
				end,
			},
			folds = { enable = true },
			ensure_installed = "all",
		},
		config = function()
			-- Automatically start treesitter for supported filetypes
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local lang = vim.treesitter.language.get_lang(args.match) or args.match
					local installed = require("nvim-treesitter").get_installed("parsers")
					if vim.tbl_contains(installed, lang) then
						vim.treesitter.start(args.buf)
					end
				end,
			})
			-- use bash parser for zsh files
			vim.treesitter.language.register("bash", "zsh")
		end,
	},
}
