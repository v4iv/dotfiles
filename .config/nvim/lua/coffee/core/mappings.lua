local map = vim.keymap.set

map("i", "jk", "<Esc>")
map("t", "jk", "<C-><C-n>")
map("i", "<C-b>", "<ESC>^i", { desc = "Move Beginning of Line" })
map("i", "<C-e>", "<End>", { desc = "Move End of Line" })
map("i", "<C-h>", "<Left>", { desc = "Move Left" })
map("i", "<C-l>", "<Right>", { desc = "Move Right" })
map("i", "<C-j>", "<Down>", { desc = "Move Down" })
map("i", "<C-k>", "<Up>", { desc = "Move Up" })

map("n", "<C-h>", "<C-w>h", { desc = "Switch Window Left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch Window Right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch Window Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch Window Up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear Highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "General Save File" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "General Copy Whole File" })

map("n", "<leader>q", "<C-w>q", { desc = "Close The Buffer" })
-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle Comment", remap = true })

-- global lsp mappings
map("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [d]iagnostic [q]uickfix List" })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Terminal Escape Terminal Mode" })

-- lazy
map("n", "<leader>lz", "<cmd>Lazy<cr>", { desc = "Lazy Plugin Manager" })
