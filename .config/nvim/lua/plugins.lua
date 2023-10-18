local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use "wbthomason/packer.nvim"

  use "ggandor/leap.nvim"

  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"

  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "hiphish/rainbow-delimiters.nvim"

  use { "stevedylandev/flexoki-nvim", as = "flexoki" }
  
  use "neovim/nvim-lspconfig"
  use "jose-elias-alvarez/null-ls.nvim"
  use "jose-elias-alvarez/nvim-lsp-ts-utils"

  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"

  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"

  use "tpope/vim-fugitive"
  use "tpope/vim-surround"

  use "nvim-telescope/telescope.nvim"

  use "https://codeberg.org/esensar/nvim-dev-container"

  use 'folke/tokyonight.nvim'
  use "rafamadriz/neon"

  use "itchyny/lightline.vim"

  use "nvim-tree/nvim-web-devicons"
  use "nvim-tree/nvim-tree.lua"

  use "stevearc/aerial.nvim"

  use "github/copilot.vim"

  use "windwp/nvim-ts-autotag"
  use 'windwp/nvim-projectconfig'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
