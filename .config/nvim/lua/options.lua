vim.opt["completeopt"]="menu,menuone,noselect"

vim.opt["hidden"] = true

vim.opt["signcolumn"] = "yes"
vim.opt["tabstop"] = 2
vim.opt["shiftwidth"] = 4

vim.opt["autoread"] = true

vim.opt["mouse"] = "a"

vim.opt["undodir"] = vim.env.HOME .. "/.vim/undofiles5"
vim.opt["undofile"] = true

vim.opt["expandtab"] = true

vim.opt["termguicolors"] = true

vim.opt["number"] = true
vim.opt["relativenumber"] = true
vim.opt["scrolloff"] = 15
vim.opt["cursorline"] = true
vim.opt["ignorecase"] = true
vim.opt["smartcase"] = true
vim.opt["autoread"] = true

vim.opt["backup"] = false
vim.opt["writebackup"] = false

vim.opt["cmdheight"] = 2

vim.opt["updatetime"] = 300

vim.cmd("filetype on")
