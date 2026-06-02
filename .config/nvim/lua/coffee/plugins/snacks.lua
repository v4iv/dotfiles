return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			animate = { enabled = true },
			bigfile = { enabled = true },
			bufdelete = { enabled = true },
			explorer = { enabled = true, replace_newtr = true },
			git = { enabled = true },
			gitbrowse = { enabled = true },
			image = { enabled = true },
			indent = { enabled = true, hl = "SnacksIndent" },
			input = { enabled = true },
			lazygit = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			terminal = { enabled = true },
			words = { enabled = true },

			-- Picker
			picker = {
				enabled = true,
				icons = {
					git = {
						enabled = true,
						staged = "●",
						added = "",
						deleted = "󰚃",
						ignored = "",
						modified = "M",
						renamed = "R",
						untracked = "U",
						unmerged = "",
					},
				},

				sources = {
					files = {
						hidden = true,
						ignored = true,
						win = {
							input = {
								keys = {
									["<S-h>"] = "toggle_hidden",
									["<S-i>"] = "toggle_ignored",
									["<S-f>"] = "toggle_follow",
									["<C-y>"] = { "yazi_copy_relative_path", mode = { "n", "i" } },
								},
							},
						},
						exclude = {
							"**/.git/*",
							"**/node_modules/*",
							"**/.yarn/cache/*",
							"**/.yarn/install*",
							"**/.yarn/releases/*",
							"**/.pnpm-store/*",
							"**/.idea/*",
							"**/.DS_Store",
							"build/*",
							"coverage/*",
							"dist/*",
							"hodor-types/*",
							"**/target/*",
							"**/public/*",
							"**/digest*.txt",
							"**/.node-gyp/**",
							"**/.svelte-kit/**",
							"**/.astro/**",
						},
					},

					grep = {
						hidden = true,
						ignored = true,
						win = {
							input = {
								keys = {
									["<S-h>"] = "toggle_hidden",
									["<S-i>"] = "toggle_ignored",
									["<S-f>"] = "toggle_follow",
								},
							},
						},
						exclude = {
							"**/.git/*",
							"**/node_modules/*",
							"**/.yarn/cache/*",
							"**/.yarn/install*",
							"**/.yarn/releases/*",
							"**/.pnpm-store/*",
							"**/.venv/*",
							"**/.idea/*",
							"**/.DS_Store",
							"**/yarn.lock",
							"build*/*",
							"coverage/*",
							"dist/*",
							"certificates/*",
							"hodor-types/*",
							"**/target/*",
							"**/public/*",
							"**/digest*.txt",
							"**/.node-gyp/**",
							"**/.svelte-kit/**",
							"**/.astro/**",
						},
					},

					grep_buffers = {},

					explorer = {
						hidden = true,
						ignored = true,
						supports_live = true,
						auto_close = true,
						diagnostics = true,
						diagnostics_open = false,
						focus = "list",
						follow_file = true,
						git_status = true,
						git_status_open = true,
						git_untracked = true,
						jump = { close = true },
						tree = true,
						watch = true,
						exclude = {
							".git",
							".pnpm-store",
							".venv",
							".DS_Store",
							"**/.node-gyp/**",
						},
					},
				},
			},

			-- Toggle
			toggle = {
				enabled = true,
				map = vim.keymap.set, -- keymap.set function to use
				which_key = true,
				notify = true, -- show a notification when toggling
				-- icons for enabled/disabled states
				icon = {
					enabled = " ",
					disabled = " ",
				},
				-- colors for enabled/disabled states
				color = {
					enabled = "green",
					disabled = "yellow",
				},
				wk_desc = {
					enabled = "Disable ",
					disabled = "Enable ",
				},
			},

			-- Dashboard
			dashboard = {
				enabled = true,
				preset = {
					-- Used by the `keys` section to show keymaps.
					-- Set your custom keymaps here.
					-- When using a function, the `items` argument are the default keymaps.
					---@type snacks.dashboard.Item[]
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{
							icon = " ",
							key = "e",
							desc = "File Explorer",
							action = function()
								Snacks.explorer()
							end,
						},
						{
							icon = "",
							key = "g",
							desc = "Find Text",
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{
							icon = "󰒲 ",
							key = "L",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
				sections = {
					{
						section = "terminal",
						cmd = 'figlet -f ~/.config/figlet/fonts/ansi_shadow.flf "  DON\'T\n  PANIC" | lolcat -F 0.3 -t -p 100 -f; sleep .1',
						height = 15,
						padding = 1,
						random = 10,
					},
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
					{
						section = "terminal",
						cmd = "krabby random --no-title; sleep .1",
						random = 999,
						pane = 2,
						indent = 4,
						height = 30,
					},
					-- { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					-- {
					-- 	pane = 2,
					-- 	icon = " ",
					-- 	title = "Git Status",
					-- 	section = "terminal",
					-- 	enabled = function()
					-- 		return Snacks.git.get_root() ~= nil
					-- 	end,
					-- 	cmd = "git status --short --branch --renames",
					-- 	height = 5,
					-- 	padding = 1,
					-- 	ttl = 5 * 60,
					-- 	indent = 3,
					-- },
				},
			},
		},
		keys = {
			-- Top Pickers & Explorer
			{
				"<leader><space>",
				function()
					Snacks.picker.smart()
				end,
				desc = "Smart Find Files",
			},
			{
				"<leader>,",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fw",
				function()
					Snacks.picker.grep()
				end,
				desc = "Snacks Grep",
			},
			{
				"<leader>:",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Command History",
			},
			{
				"gn",
				function()
					Snacks.picker.notifications()
				end,
				desc = "Notification History",
			},
			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "File Explorer",
			},
			-- find
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fc",
				function()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Find Config File",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Find Git Files",
			},
			{
				"<leader>fp",
				function()
					Snacks.picker.projects()
				end,
				desc = "Projects",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = "Recent",
			},
			-- git
			{
				"<leader>gb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Git Branches",
			},
			{
				"<leader>gl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<leader>gL",
				function()
					Snacks.picker.git_log_line()
				end,
				desc = "Git Log Line",
			},
			{
				"<leader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},
			{
				"<leader>gS",
				function()
					Snacks.picker.git_stash()
				end,
				desc = "Git Stash",
			},
			{
				"<leader>gd",
				function()
					Snacks.picker.git_diff()
				end,
				desc = "Git Diff (Hunks)",
			},
			{
				"<leader>gf",
				function()
					Snacks.picker.git_log_file()
				end,
				desc = "Git Log File",
			},
			-- Grep
			{
				"<leader>sb",
				function()
					Snacks.picker.lines()
				end,
				desc = "Buffer Lines",
			},
			{
				"<leader>sB",
				function()
					Snacks.picker.grep_buffers()
				end,
				desc = "Grep Open Buffers",
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>sw",
				function()
					Snacks.picker.grep_word()
				end,
				desc = "Visual selection or word",
				mode = { "n", "x" },
			},
			-- search
			{
				'<leader>s"',
				function()
					Snacks.picker.registers()
				end,
				desc = "Registers",
			},
			{
				"<leader>s/",
				function()
					Snacks.picker.search_history()
				end,
				desc = "Search History",
			},
			{
				"<leader>sa",
				function()
					Snacks.picker.autocmds()
				end,
				desc = "Autocmds",
			},
			{
				"<leader>sb",
				function()
					Snacks.picker.lines()
				end,
				desc = "Buffer Lines",
			},
			{
				"<leader>sc",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Command History",
			},
			{
				"<leader>sC",
				function()
					Snacks.picker.commands()
				end,
				desc = "Commands",
			},
			{
				"<leader>sd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>sD",
				function()
					Snacks.picker.diagnostics_buffer()
				end,
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>sh",
				function()
					Snacks.picker.help()
				end,
				desc = "Help Pages",
			},
			{
				"<leader>sH",
				function()
					Snacks.picker.highlights()
				end,
				desc = "Highlights",
			},
			{
				"<leader>si",
				function()
					Snacks.picker.icons()
				end,
				desc = "Icons",
			},
			{
				"<leader>sj",
				function()
					Snacks.picker.jumps()
				end,
				desc = "Jumps",
			},
			{
				"<leader>sk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "Keymaps",
			},
			{
				"<leader>sl",
				function()
					Snacks.picker.loclist()
				end,
				desc = "Location List",
			},
			{
				"<leader>sm",
				function()
					Snacks.picker.marks()
				end,
				desc = "Marks",
			},
			{
				"<leader>sM",
				function()
					Snacks.picker.man()
				end,
				desc = "Man Pages",
			},
			{
				"<leader>sp",
				function()
					Snacks.picker.lazy()
				end,
				desc = "Search for Plugin Spec",
			},
			{
				"<leader>sq",
				function()
					Snacks.picker.qflist()
				end,
				desc = "Quickfix List",
			},
			{
				"<leader>sR",
				function()
					Snacks.picker.resume()
				end,
				desc = "Resume",
			},
			{
				"<leader>su",
				function()
					Snacks.picker.undo()
				end,
				desc = "Undo History",
			},
			{
				"<leader>uC",
				function()
					Snacks.picker.colorschemes()
				end,
				desc = "Colorschemes",
			},
			-- LSP
			{
				"gd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "Goto Definition",
			},
			{
				"gD",
				function()
					Snacks.picker.lsp_declarations()
				end,
				desc = "Goto Declaration",
			},
			{
				"gR",
				function()
					Snacks.picker.lsp_references()
				end,
				nowait = true,
				desc = "References",
			},
			{
				"gI",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
			{
				"gy",
				function()
					Snacks.picker.lsp_type_definitions()
				end,
				desc = "Goto T[y]pe Definition",
			},
			{
				"gai",
				function()
					Snacks.picker.lsp_incoming_calls()
				end,
				desc = "C[a]lls Incoming",
			},
			{
				"gao",
				function()
					Snacks.picker.lsp_outgoing_calls()
				end,
				desc = "C[a]lls Outgoing",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "LSP Symbols",
			},
			{
				"<leader>sS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "LSP Workspace Symbols",
			},
			-- terminal
			{
				"<leader>ft",
				function()
					Snacks.terminal()
				end,
				desc = "Terminal (cwd)",
				mode = "n",
			},
			{
				"<leader>fT",
				function()
					Snacks.terminal(nil, { cwd = vim.fn.getcwd() })
				end,
				desc = "Terminal (Root Dir)",
				mode = "n",
			},
			{
				"<c-/>",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{
				"<c-:>",
				function()
					Snacks.terminal(nil, { cwd = vim.fn.getcwd() })
				end,
				desc = "which_key_ignore",
				mode = "n",
			},
			{
				"<c-_>",
				function()
					Snacks.terminal(nil, { cwd = vim.fn.getcwd() })
				end,
				desc = "which_key_ignore",
				mode = "n",
			},
			-- Other
			{
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
			{
				"<leader>Z",
				function()
					Snacks.zen.zoom()
				end,
				desc = "Toggle Zoom",
			},
			{
				"<leader>n",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
			{
				"<leader>x",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
				mode = { "n", "v" },
			},
			{
				"<leader>lg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "which_key_ignore",
			},
			{
				"<leader>N",
				desc = "Neovim News",
				function()
					Snacks.win({
						file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
						width = 0.6,
						height = 0.6,
						wo = {
							spell = false,
							wrap = false,
							signcolumn = "yes",
							statuscolumn = " ",
							conceallevel = 3,
						},
					})
				end,
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end

					-- Override print to use snacks for `:=` command
					if vim.fn.has("nvim-0.11") == 1 then
						vim._print = function(_, ...)
							dd(...)
						end
					else
						vim.print = _G.dd
					end

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle
						.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map("<leader>uc")
					Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle
						.option("background", { off = "light", on = "dark", name = "Dark Background" })
						:map("<leader>ub")
					Snacks.toggle.inlay_hints():map("<leader>uh")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.dim():map("<leader>uD")
				end,
			})
		end,
		-- patch Snacks.util.icons to enable nvim-web-devicons https://github.com/folke/snacks.nvim/discussions/1638
		config = function(_, opts)
			require("snacks").setup(opts)
			Snacks.util.icon = function(name, cat, opts)
				opts = opts or {}
				opts.fallback = opts.fallback or {}
				local try = {
					function()
						if cat == "directory" then
							return opts.fallback.dir or "󰉋 ", "Directory"
						end
						local Icons = require("nvim-web-devicons")
						if cat == "filetype" then
							return Icons.get_icon_by_filetype(name, { default = false })
						elseif cat == "file" then
							local ext = name:match("%.(%w+)$")
							-- use basename here <----------
							return Icons.get_icon(vim.fs.basename(name), ext, { default = false }) --[[@as string, string]]
						elseif cat == "extension" then
							return Icons.get_icon(nil, name, { default = false }) --[[@as string, string]]
						end
					end,
				}
				for _, fn in ipairs(try) do
					local ret = { pcall(fn) }
					if ret[1] and ret[2] then
						return ret[2], ret[3]
					end
				end
				return opts.fallback.file or "󰈔 "
			end
		end,
	},
}
