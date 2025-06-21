-- Yank to system clipboard
vim.keymap.set('v', '<C-c>', '"+y', { noremap = true, silent = true, desc = 'Yank to system clipboard' })

-- Paste from system clipboard
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true, silent = true, desc = 'Paste from system clipboard' })

-- Key mappings for Neovim
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader>w', vim.cmd.w)
vim.keymap.set('n', '<leader>q', function() vim.cmd('q!') end, { noremap = true, silent = true })

