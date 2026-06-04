return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local p = require("houston.palette")
		require("lualine").setup({
			options = { theme = "houston" },
			sections = {
				lualine_x = {
					-- {
					-- 	require("noice").api.status.message.get_hl,
					-- 	cond = require("noice").api.status.message.has,
					-- },
					{
						-- show recording mode
						function()
							return require("noice").api.status.mode.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.mode.has()
						end,
						color = { fg = p.peach },
					},
					-- {
					-- 	function()
					-- 		return require("noice").api.status.command.get()
					-- 	end,
					-- 	cond = function()
					-- 		return package.loaded["noice"] and require("noice").api.status.command.has()
					-- 	end,
					-- 	color = { fg = p.cyan },
					-- },
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_c = {
					"filename",
					{
						-- show search results count
						function()
							-- trim the message to include only the count in between large brackets
							local count = require("noice").api.status.search.get()
							return string.match(count, "%[(.*)%]") .. " matches"
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.search.has()
						end,
						color = { fg = p.mint },
					},
				},
			},
		})
	end,
}
