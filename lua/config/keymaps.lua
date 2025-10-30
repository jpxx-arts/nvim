-- Yank to system clipboard
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, silent = true, desc = 'Yank to system clipboard' })

-- Paste from system clipboard
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true, silent = true, desc = 'Paste from system clipboard' })

-- Key mappings for Neovim
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader>w', vim.cmd.w)
vim.keymap.set('n', '<leader>q', function() vim.cmd('q!') end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>Q', '<cmd>qa!<CR>', { desc = 'Close nvim completely' })

-- Shortcuts for Insert mode
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-w>', { noremap = true })

-- Move lines up and down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true, desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true, desc = 'Move line up' })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move lines down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move lines down" })

-- Center the screen when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Swtich between windows
vim.keymap.set({ "n", "t" }, '<C-h>', [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, '<C-j>', [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, '<C-k>', [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, '<C-l>', [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })

-- Terminal
vim.keymap.set("n", "<leader>th", function()
  vim.cmd("botright split | resize 8 | terminal")
end, { desc = "Horizontal Terminal" })
vim.keymap.set("n", "<leader>tv", ":botright vsplit | vertical resize 35 | terminal<CR>", { desc = "Vertical Terminal" })

local floaterminal = require("utils.floaterminal")
vim.keymap.set("n", "<leader>tt", floaterminal.toggle, { desc = "Toggle floaterminal" })
vim.keymap.set("t", "jk", "<c-\\><c-n>", { desc = "Exit terminal mode" })

local popup_path = require("utils.popup-path")
vim.keymap.set("n", "<A-l>", popup_path.toggle_filepath, { desc = "Toggle current file path" })

-- New file
vim.keymap.set("n", "<leader>nj", function()
  require("utils.java_file_creator").create_java_file()
end, { desc = "Create a new java file" })
