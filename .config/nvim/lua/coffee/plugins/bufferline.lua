return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		opts = {
			options = {
				offsets = {
					{
						filetype = "snacks_layout_box",
						highlight = "Directory",
					},
				},
			},
		},
	},
}
