let mapleader=","
inoremap jk <Esc>
filetype plugin indent on " To ignore plugin indent changes, instead use:
syntax enable
set nocompatible              " be iMproved, required
set encoding=utf-8
set showcmd                     " display incomplete commands
set pastetoggle=<F3> " <F3> to enter paster mode
set tags=./tags; " Ctags setting
set shell=/usr/bin/zsh
set omnifunc=syntaxcomplete#CompleteCSS
set path+=**          " Search sub folders + tab completion
set wildmenu          " Display all matching files
set wildignore+=**/node_modules/** " Ignore node_modules from :find
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set splitright
set number
set relativenumber
set fo-=ro                      " Prevent auto commenting next line
" Fix ?[q cursor issue https://github.com/neovim/neovim/issues/7049
set guicursor=

"" Color
if $TERM == "xterm-256color"
  set t_Co=256
endif
set background=dark

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
fun! StripTrailingWhitespace()
    " Don't strip on these filetypes
    if &ft =~ 'markdown\|perl\|md'
        return
    endif
    %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()
" Didn't work
" let whitelist = ['md']
" autocmd BufWritePre * if index(whitelist, &ft) < 0 | %s/\s\+$//e

" Open + reload .vimrc
nnoremap <Space>.
\        :<C-u>edit ~/.vimrc<CR>
nnoremap <Space>s.
\        :<C-u>source ~/.vimrc<CR>
nnoremap <Space>h :<C-u>help<Space>
nnoremap <Space>a :<C-u>Ag<Space>
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
nnoremap <Space>n :noh<CR>
nmap <Space>c "+y
vmap <Space>c "+y


" Marks
nnoremap [Mark] <Nop>
nmap m [Mark]
" Assign random key for current mark
if !exists('g:markrement_char')
    let g:markrement_char = [
    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
endif
nnoremap <silent>[Mark]m :<C-u>call <SID>AutoMarkrement()<CR>
function! s:AutoMarkrement()
    if !exists('b:markrement_pos')
nnoremap <Space>h :<C-u>help<Space>
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
        let b:markrement_pos = 0
    else
        let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
    endif
    execute 'mark' g:markrement_char[b:markrement_pos]
    echo 'marked' g:markrement_char[b:markrement_pos]
endfunction
" Move to next / previous mark
nnoremap [Mark]n ]`
nnoremap [Mark]p [`
" Show all marks
nnoremap [Mark]l :<C-u>marks<CR>
autocmd BufReadPost * delmarks!

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Jump to new tab with ctags
nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T
" Gitblame with visualmode
vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Format JSON
command FormatJSON :%!python -m json.tool
" Disable linter
command NoLint :let ale_enabled=0

" =============================================
" Lang specific spacing

" for html/rb files, 2 spaces
" autocmd Filetype html setlocal ts=2 sw=2 expandtab
" Disable typescirpt-vim's indent and use js-indent
let g:typescript_indent_disable = 1
autocmd BufRead,BufNewFile *.ts set ts=4 sw=4 sts=4 et

" =============================================
" Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin('~/.config/nvim/plugged')
  " PlugInstall [name ...] [#threads] 	Install plugins
  " PlugUpdate [name ...] [#threads] 	Install or update plugins
  " PlugClean[!] 	Remove unused directories (bang version will clean without prompt)
  " PlugUpgrade 	Upgrade vim-plug itself
  " PlugStatus 	Check the status of plugins
  " PlugDiff 	Examine changes from the previous update and the pending changes
  " PlugSnapshot[!] [output path] 	Generate script for restoring the current snapshot of the plugins

  Plug 'airblade/vim-gitgutter'
  Plug 'jiangmiao/auto-pairs'
  Plug 'ascenator/L9'
  Plug 'digitaltoad/vim-pug'
  Plug 'elzr/vim-json'
  Plug 'flazz/vim-colorschemes'
  " Visualize undotree
  Plug 'sjl/gundo.vim'
  " Markdown support
  Plug 'godlygeek/tabular'
  Plug 'mattn/emmet-vim'
  Plug 'mileszs/ack.vim'
  Plug 'mxw/vim-jsx'
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'plasticboy/vim-markdown'
  " Pass the path to set the runtimepath properly.
  Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
  " Easier comment
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  Plug 'w0rp/ale'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rake'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'vim-ruby/vim-ruby'
  Plug 'vimwiki/vimwiki'
  Plug 'ternjs/tern_for_vim'
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer', 'for' : ['c', 'cpp', 'javascript', 'typescript', 'html','css','js', 'ts', 'rb', 'ruby'] }
  Plug 'rking/ag.vim'
  Plug 'tpope/vim-surround'
  " Typescript
  Plug 'Quramy/tsuquyomi'
  Plug 'leafgarland/typescript-vim'
  Plug 'Shougo/vimproc.vim', {'do' : 'make'}
  Plug 'juanpabloaj/vim-istanbul'
  Plug 'joukevandermaas/vim-ember-hbs'
  Plug 'jason0x43/vim-js-indent'
  " Writing easier
  Plug 'junegunn/goyo.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'kchmck/vim-coffee-script'
call plug#end()

" Need to be after colorscheme
colorscheme solarized

" ================================================
" ALE
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}
let g:ale_lint_on_text_changed = 'never'
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0

" ================================================
" NerdTree
let g:NERDSpaceDelims = 1     " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let NERDTreeShowHidden=1      " Show hidden files in NERDTree
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
let g:NERDTreeIgnore=['\~$', '.git', 'node_modules', '\.swp$', '\.pyc']

map <C-n> :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

" Shrink Nerdtree sidebar width
call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" ================================================

" COnfig for js libraries
let g:used_javascript_libs = 'underscore, react, flux, redux, chai,jquery'
let g:jsx_ext_required = 0 " let jsx highlight work without .jsx

" ================================================
" Emmet
let g:user_emmet_leader_key='<C-Y>'
let g:user_emmet_install_global = 0 " Use emmet for html & css
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}
autocmd FileType html,css EmmetInstall

" Disable folding in vim markdown
let g:vim_markdown_folding_disabled = 1

" Turn off default for multi select
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<C-h>'
let g:multi_cursor_next_key='<C-h>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_quit_key='<C-c>'
nnoremap <C-c> :call multiple_cursors#quit()<CR>

" Use silver_search for ack
let g:ackprg = 'ag --vimgrep'


" ================================================
" The Silver Searcher

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ================================================
" Vim Rspec

nnoremap <Space>s :call RunNearestSpec()<CR>

" ================================================
" Tabulize
if exists(":Tabularize")
  nmap <Space>t= :Tabularize /=<CR>
  vmap <Space>t= :Tabularize /=<CR>
  nmap <Space>t: :Tabularize /:\zs<CR>
  vmap <Space>t: :Tabularize /:\zs<CR>
endif

" ================================================
" Calendar
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" ================================================
" YouCompleteMe

if !exists("g:ycm_semantic_triggers")
 let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" ================================================
" YouCompleteMe

" Set the home to Dropbox
let g:vimwiki_list = [{'path': '$HOME/Dropbox/wiki',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" ================================================
" Ligthline

" From https://github.com/statico/dotfiles/blob/202e30b23e5216ffb6526cce66a0ef4fa7070456/.vim/vimrc#L406-L453
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [['mode', 'paste'], ['filename', 'modified']],
      \   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
      \ },
      \ 'component_expand': {
      \   'linter_warnings': 'LightlineLinterWarnings',
      \   'linter_errors': 'LightlineLinterErrors',
      \   'linter_ok': 'LightlineLinterOK'
      \ },
      \ 'component_type': {
      \   'readonly': 'error',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error'
      \ },
\ }

if !has('gui_running')
  set t_Co=256
endif

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" ================================================
" fzf

nmap <C-B> :Buffers<CR>
nmap <Leader>t :Tags<CR>
nmap <C-P> :Files<CR>

" ================================================
" 310 project config
autocmd BufRead,BufNewFile ~/uni/cs310/cpsc310_team103/* let NERDTreeIgnore = ['\.js$', '\.js.map$']

" ================================================
" Writing
autocmd BufRead,BufNewFile *.md setlocal wrap
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.md set complete+=kspell
nmap <C-F> z=
" nmap <Leader>g ,w,w:Goyo<CR>
 nmap <Space>g :Goyo<CR>
" Gundo
nmap <Leader>g :GundoToggle<CR>

" ================================================
" matchit
source $VIMRUNTIME/macros/matchit.vim
let b:match_ignorecase = 1
nmap <Tab> %
