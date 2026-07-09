return {
	{
		"saghen/blink.cmp",
		event = "VeryLazy",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"saghen/blink.lib",
			"rafamadriz/friendly-snippets",
			{
				"folke/lazydev.nvim", -- for lua files only
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			"onsails/lspkind.nvim",
			"timrydefalk/blink-cmp-emoji",
		},
		build = function()
			-- build the fuzzy matcher, optionally add a timeout to `pwait(timeout_ms)`
			-- you can use `gb` in `:Lazy` to rebuild the plugin as needed
			require("blink.cmp").build():pwait()
		end,
		-- If you use nix, you can build from source with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open (requires disabling input source keyboard shortcut in macos settings)
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = "default",
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "normal",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				documentation = { auto_show = false },
				accept = { auto_brackets = { enabled = true } },
				ghost_text = { enabled = true, show_with_menu = true },
				list = {
					selection = { preselect = false, auto_insert = true },
				},
				menu = {
					-- LSPKind and NVIM Web Devicons
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									else
										icon = require("lspkind").symbol_map[ctx.kind] or ""
									end

									return icon .. ctx.icon_gap
								end,

								-- Optionally, use the highlight groups from nvim-web-devicons
								-- You can also add the same function for `kind.highlight` if you want to
								-- keep the highlight groups in sync with the icons.
								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
									return hl
								end,
							},
						},
					},
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "emoji" },
				per_filetype = {
					lua = { inherit_defaults = true, "lazydev" },
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					emoji = {
						module = "blink-cmp-emoji",
						name = "blink-cmp-emoji",
						max_items = 10,
						min_keyword_length = 1,
						score_offset = 10,
						opts = {
							trigger = ":",
						},
					},
				},
			},

			signature = { enabled = true },
			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"`
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "rust" },
		},
	},
}
