return {
	{ "m00qek/baleia.nvim" },
	{ "nvim-lua/plenary.nvim" }, -- lua functions that many plugins use
	{ "nvim-tree/nvim-web-devicons", opts = { default = true } }, -- used for icons
	-- {
	-- 	"nvim-mini/mini.icons",
	-- 	opts = {},
	-- 	lazy = true,
	-- 	version = "*",
	-- 	config = function()
	-- 		require("mini.icons").setup()
	-- 	end,
	-- 	-- specs = {
	-- 	-- 	{ "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
	-- 	-- },
	-- 	-- init = function()
	-- 	-- 	package.preload["nvim-web-devicons"] = function()
	-- 	-- 		require("mini.icons").mock_nvim_web_devicons()
	-- 	-- 		return package.loaded["nvim-web-devicons"]
	-- 	-- 	end
	-- 	-- end,
	-- },
}
