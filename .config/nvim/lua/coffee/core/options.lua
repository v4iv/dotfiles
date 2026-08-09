local opt = vim.opt
local o = vim.o
local cmd = vim.cmd

-------------------------------------- options ------------------------------------------
-- colorscheme
cmd.colorscheme("houston")

-- editor
o.laststatus = 3
o.showmode = false
o.splitkeep = "screen"

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

-- tabs & indentation
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

o.signcolumn = "yes"
o.timeoutlen = 400
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
o.confirm = true

-- LSP
local severity = vim.diagnostic.severity

vim.diagnostic.config({
	virtual_text = {
		prefix = function(diagnostic)
			local icons = {
				[severity.ERROR] = " ",
				[severity.WARN] = " ",
				[severity.INFO] = " ",
				[severity.HINT] = "󰠠 ",
			}
			return icons[diagnostic.severity] or "● "
		end,
	},
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.HINT] = "󰠠 ",
			[severity.INFO] = " ",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
	},
})

-- folding
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true

-- don't show Process exited 0
vim.api.nvim_clear_autocmds({ group = "nvim.terminal", event = "TermClose" })
