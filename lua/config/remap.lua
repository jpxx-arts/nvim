-- Yank to system clipboard
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, silent = true, desc = 'Yank to system clipboard' })

-- Paste from system clipboard
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true, silent = true, desc = 'Paste from system clipboard' })

