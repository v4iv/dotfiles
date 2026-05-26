return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local p = require("houston.palette")
		require("lualine").setup({
			options = { theme = "houston" },
			sections = {
				lualine_x = {
					{
						require("noice").api.status.mode.get,
						cond = require("noice").api.status.mode.has,
						color = { fg = p.peach },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
			},
		})
	end,
}
