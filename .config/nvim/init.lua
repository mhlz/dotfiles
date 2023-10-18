require("options")
require("plugins")
require("tree")
require("lsp")
require("completion")

require("devcontainer").setup{}

require("projectconfig")
require("autotag-config")
require("aerial-config")
require("treesitter-config")
require("telescope-config")
require("lightline-config")

require("keybinds")

vim.cmd("colorscheme flexoki")
