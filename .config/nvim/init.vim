call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'

Plug 'christianchiarulli/nvcode-color-schemes.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'neovim/nvim-lspconfig'
Plug 'mbbill/undotree'
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdtree'

Plug 'hrsh7th/nvim-compe'

Plug 'mhartington/formatter.nvim'

" dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" telescope
Plug 'nvim-telescope/telescope.nvim'

Plug 'tpope/vim-surround'
call plug#end()

lua << EOF
local nvim_lsp = require('lspconfig')
local util = nvim_lsp.util

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

require "lspconfig".efm.setup {
  init_options = {documentFormatting = true},
  filetypes = {"javascript", "typescript"},
  root_dir = function(fname)
    return util.root_pattern("tsconfig.json")(fname) or
    util.root_pattern(".eslintrc.js", ".git")(fname);
  end,
  settings = {
    rootMarkers = {".eslintrc.js", ".git/"},
    languages = {
      javascript = {eslint},
      typescript = {eslint}
    }
  }
}

require("formatter").setup(
  {
    logging = true,
    filetype = {
      typescriptreact = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
      },
      typescript = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
      },
      javascript = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
      },
      javascriptreact = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
      },
      json = {
        -- prettier
        function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap("i", "<C-y>", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '<C-E>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', '<C-e>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "tsserver", "diagnosticls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

vim.api.nvim_set_keymap('i', '<leader>f', '<cmd>Format<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>Format<CR>', {noremap = true})
vim.api.nvim_set_keymap('i', '<leader>o', '<cmd>lua organizeImports()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>lua organizeImports()<CR>', {noremap = true})

function organizeImports()
  local params = vim.lsp.util.make_range_params()
  params.context = {diagnostics = {}, only = {'source.organizeImports'}}

  local responses = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)

  if not responses or vim.tbl_isempty(responses) then
    return
  end

  for _, response in pairs(responses) do
    for _, result in pairs(response.result or {}) do
      if result.edit then
        vim.lsp.util.apply_workspace_edit(result.edit)
      else
        vim.lsp.buf.execute_command(result.command)
      end
    end
  end
end

EOF

set hidden
set signcolumn=yes
set tabstop=4
set shiftwidth=4
set autoread
set mouse=a
set noshowmode

set undodir=~/.vim/undofiles5
set undofile

set expandtab
au FileType go set noexpandtab
" Colors
if (has("termguicolors"))
  set termguicolors
endif

" Settings
set number
set relativenumber
set scrolloff=15
set cursorline
set ignorecase
set smartcase
set autoread

" Key Mappings/keymappings
"

vmap < <gv
vmap > >gv

vnoremap gy "*y

vnoremap <c-/> :TComment<cr>

noremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

vnoremap <leader>c "+y
vnoremap <leader>y "+y
nnoremap <leader>yy "+yy
nnoremap <leader>p "+p
vnoremap <leader>p "+p
vnoremap <leader>x "+d
nnoremap <silent> <Esc> :nohl<CR>

nnoremap <C-n> :NERDTreeToggle<CR>

filetype on

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Completion
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true

inoremap <silent><expr> <CR>      compe#confirm('<CR>')


" Finding things
nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <C-p> <cmd>Telescope live_grep<cr>


" Colors
" configure nvcode-color-schemes
let g:nvcode_termcolors=256

syntax on
colorscheme nvcode " Or whatever colorscheme you make


" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

" Lightline
function! LightlineFilename()
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    if path[:len(root)-1] ==# root
        return path[len(root)+1:]
    endif
    return expand('%')
 endfunction

" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ],
  	  \   'right': [ ['fugitive'], [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status'
      \ },
      \ }

function! LightlineFugitive() abort
  if &filetype ==# 'help'
    return ''
  endif
  if has_key(b:, 'lightline_fugitive') && reltimestr(reltime(b:lightline_fugitive_)) =~# '^\s*0\.[0-5]'
    return b:lightline_fugitive
  endif
  try
    if exists('*fugitive#head')
      let head = fugitive#head()
    else
      return ''
    endif
    let b:lightline_fugitive = head
    let b:lightline_fugitive_ = reltime()
    return b:lightline_fugitive
  catch
  endtry
  return ''
endfunction

