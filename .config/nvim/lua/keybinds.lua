require('leap').set_default_keymaps()

vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true})
vim.api.nvim_set_keymap('v', 'gy', '"*y', {noremap = true})

vim.api.nvim_set_keymap('v', '<leader>c', '"+y', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>x', '"+d', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>yy', '"+yy', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', {noremap = true})
vim.api.nvim_set_keymap('n', '<Esc>', ':nohl<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('', '<C-J>', '<C-W>j', {noremap = true})
vim.api.nvim_set_keymap('', '<C-K>', '<C-W>k', {noremap = true})
vim.api.nvim_set_keymap('', '<C-L>', '<C-W>l', {noremap = true})
vim.api.nvim_set_keymap('', '<C-H>', '<C-W>h', {noremap = true})

vim.api.nvim_set_keymap('', '<C-N>', ':NvimTreeToggle<CR>', {noremap = true})
