return {
	{
		"mfussenegger/nvim-dap",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local map = vim.keymap.set
			local dap = require("dap")
			local dapui = require("dapui")
			local dapvirtualtext = require("nvim-dap-virtual-text")

			dapui.setup()
			dapvirtualtext.setup({})

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			map("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle Break" })
			map("n", "<leader>dc", dap.continue, { desc = "Continue" })
			map("n", "<leader>dr", dap.repl.open, { desc = "Inspect" })
			map("n", "<leader>dk", dap.terminate, { desc = "Kill" })

			map("n", "<leader>dso", dap.step_over, { desc = "Step Over" })
			map("n", "<leader>dsi", dap.step_into, { desc = "Step Into" })
			map("n", "<leader>dsu", dap.step_out, { desc = "Step Out" })
			map("n", "<leader>dl", dap.run_last, { desc = "Run Last" })

			map("n", "<leader>duu", dapui.open, { desc = "Open DAP UI" })
			map("n", "<leader>duc", dapui.close, { desc = "Close DAP UI" })
		end,
	},
}
