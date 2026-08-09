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
			indent = { enable = true },
			highlight = {
				enable = true,

				disable = function(_, buf)
					local max_filesize = 100 * 1024
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
			ensure_installed = "all",
		},

		config = function(_, opts)
			require("nvim-treesitter").setup(opts)

			-- use bash parser for zsh files
			vim.treesitter.language.register("bash", "zsh")

			vim.keymap.set("n", "<leader>ti", "<cmd>InspectTree<CR>", {
				desc = "Inspect Tree-sitter tree",
			})
		end,
	},
}
