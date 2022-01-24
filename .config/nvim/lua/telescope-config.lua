
vim.api.nvim_set_keymap(
    "n",
    "<C-f>",
    "<cmd>Telescope find_files<cr>",
    { noremap = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<C-p>",
    "<cmd>Telescope live_grep<cr>",
    { noremap = true }
)
