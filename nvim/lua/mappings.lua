local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Switch buffers
map("n", "<Tab>", ":bnext<CR>")
map("n", "<S-Tab>", ":bprevious<CR>")

-- Better buffer close
map("n", "<leader>q", "<cmd>Bdelete!<CR>")

-- Better buffer navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Create splits easily
map("n", "<leader>h", ":split<cr>")
map("n", "<leader>v", ":vsplit<cr>")

-- Faster split resize
map("n", "<C-S-Left>", ":vertical resize +3<cr>")
map("n", "<C-S-Right>", ":vertical resize -3<cr>")
map("n", "<C-S-Up>", ":resize +3<cr>")
map("n", "<C-S-Down>", ":resize -3<cr>")

--After searching, pressing escape stops the highlight
map("n", "<esc>", ":noh<cr><esc>")

-- Hop(EasyMotion) for normal and visual modes
map("n", "<leader><space>", "<cmd>lua require'hop'.hint_char1()<cr>")
map("v", "<leader><space>", "<cmd>lua require'hop'.hint_char1()<cr>")

-- Filetree
-- M is mapped to Cmd in iTerm2 preferences
map("n", "<M-b>", ":NvimTreeToggle<CR>")

-- Telescope

vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })

-- Replaced this one with hop. See if i need this
-- vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })

-- TODO: Check if this one will be helpful to me
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

vim.keymap.set("n", "<leader>gs", require("telescope.builtin").git_status, { desc = "[G]it [S]tatus" })

-- Bufferline
map("n", "<leader>b", ":BufferLinePick<cr>")
map("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>")
map("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>")
map("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>")
map("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>")
map("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>")
map("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>")
map("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>")
map("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>")
map("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>")

-- Display diagnostics messages
map("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Show diagnostic message in float window" })
map("n", "<leader>xx", "<cmd>Trouble<cr>", { desc = "Diagnostics" })
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { desc = "Workspace Diagnostics" })
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { desc = "Document diagnostics" })

map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

-- Database
map("n", "<leader>du", "<cmd>DBUIToggle<cr>", { desc = "[D]atabase [U]i" })

-- Editing shortcuts
map("n", "<leader>r", ":%s///g<left><left>", { silent = false, desc = "Quick replace selected text" })
