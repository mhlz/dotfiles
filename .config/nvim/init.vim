call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

"A dependency of 'ncm2'.
"Plug 'roxma/nvim-yarp'

"v2 of the nvim-completion-manager.
"Plug 'ncm2/ncm2'

Plug 'tpope/vim-fugitive'

" LanguageServer client for NeoVim.
"Plug 'autozimu/LanguageClient-neovim', {
"  \ 'branch': 'next',
"  \ 'do': 'bash install.sh',
"  \ }

Plug 'editorconfig/editorconfig-vim'

Plug 'udalov/kotlin-vim'

Plug 'tpope/vim-surround'

" Plug 'mhartington/oceanic-next'
" Plug 'artanikin/vim-synthwave84'
" Plug 'isobit/vim-darcula-colors'
" Plug 'jcorbin/darkula'

Plug 'scrooloose/nerdtree'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Plug 'othree/yajs.vim'
" Plug 'othree/es.next.syntax.vim'
Plug 'HerringtonDarkholme/yats.vim'

" Plug '/Users/mhlz/proj/darcooler'
Plug '/home/mhlz/proj/darcooler-vim'

" Plug 'takac/vim-hardtime'
call plug#end()

let g:hardtime_default_on = 1
let g:hardtime_ignore_buffer_patterns = [ "NERD.*" ]

let g:yats_host_keyword = 0
let g:yajs_host_keyword = 0

" let g:deoplete#enable_at_startup = 1
"" Completion stuff
"autocmd BufEnter  *  call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone
"
"let g:LanguageClient_serverCommands = {
"  \ 'typescript': ['typescript-language-server', '--stdio']
"  \ }
"
" Required for operations modifying multiple buffers like rename.
set hidden
set signcolumn=yes
set tabstop=4
set shiftwidth=4
set autoread
set mouse=a
set noshowmode

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

" Theme
syntax enable
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
" colorscheme OceanicNext
" colorscheme synthwave84
colorscheme darcooler

function! AgFzf(query, fullscreen)
  let command_fmt = 'ag -C 0 --nobreak --nogroup --column --line-number --noheading --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Ag call AgFzf(<q-args>, <bang>0)

" Keymaps
nnoremap ; :
nnoremap : <nop>
vmap < <gv
vmap > >gv
nnoremap <leader>d "_d
vnoremap <leader>d "_d

vnoremap gy "*y

vnoremap <c-/> :TComment<cr>

noremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

nnoremap <C-n> :NERDTreeToggle<CR>

nnoremap <silent> <expr> <C-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Ag\<cr>"
nnoremap <silent> <expr> <C-f> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"

nnoremap 0 ^
nnoremap ^ 0

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

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <C-e> <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

nnoremap ff :CocAction<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorMoved * silent call CocActionAsync('highlight')
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use TS highlighting for JS files
autocmd BufNewFile,BufRead *.js set syntax=typescript

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
nmap <leader>f  <Plug>(coc-format)
xmap <leader>f  <Plug>(coc-format)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

nmap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :execute "normal \<Plug>(coc-format)"

function! Format() abort
	let eslintTypes = [ "javascript", "typescript", "json" ]
	let idx = index(eslintTypes, &ft)
    if &ft == "javascript"
		:CocCommand eslint.executeAutofix
    elseif &ft == "typescript"
        :CocCommand tslint.fixAllProblems
	else
		:call CocAction('format')
	endif
endfunction

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

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
      \ 'colorscheme': 'darcula',
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



" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

vnoremap <leader>c "+y
vnoremap <leader>y "+y
nnoremap <leader>yy "+yy
nnoremap <leader>p "+p
vnoremap <leader>p "+p
vnoremap <leader>x "+d


" Color scheme development
function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

nnoremap <leader>hl :call SynGroup()<CR>

nnoremap <Esc> :nohl<CR>

syntax sync minlines=10000

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
