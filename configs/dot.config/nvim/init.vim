set nocompatible
set encoding=utf-8


"
" Package management
" https://github.com/k-takata/minpac
"
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('kien/ctrlp.vim')
call minpac#add('dracula/vim', {'name': 'dracula-theme'})
call minpac#add('rking/ag.vim')
call minpac#add('scrooloose/nerdcommenter')
call minpac#add('scrooloose/nerdtree')
call minpac#add('dense-analysis/ale')
call minpac#add('tpope/vim-bundler')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-sensible')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('vim-scripts/spacehi.vim')
call minpac#add('kassio/neoterm')
call minpac#add('vim-test/vim-test')

command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()

"
" Ale
"
let g:ale_lint_on_text_changed='never'
"let g:ale_lint_on_text_changed=1
let g:ale_lint_on_save=1
let g:ale_linters = {
\   'javascript': ['prettier'],
\   'ruby': ['standardrb'],
\   'shell': ['shellcheck'],
\   'typescript': ['tslint'],
\   'erb': ['erblint'],
\}
"\   'ruby': ['standardrb'],

"let g:ale_fix_on_save=1
let g:ale_fixers = {
\   'elixir': ['mix_format'],
\   'javascript': ['prettier'],
\   'python': ['autopep8'],
\   'ruby': ['standardrb'],
\   'shell': ['shellcheck'],
\   'typescript': ['prettier'],
\   'erb': ['erblint'],
\}
"\   'ruby': ['standardrb'],

command! Fix ALEFix

"
" CtrlP
"
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules|bower_components)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" Additionally, it will also ignore files listed in `wildignore`

"
" Neoterm + vim-test
"
let g:neoterm_default_mod='vertical'
"let g:neoterm_size=50
"let g:neoterm_fixedsize=50
let g:neoterm_autoscroll=1

let test#strategy = "neoterm"
nnoremap <silent> <Leader>a :TestSuite<cr>
nnoremap <silent> <Leader>c :TestNearest<cr>
nnoremap <silent> <Leader>f :TestFile<cr>
nnoremap <silent> <Leader><Leader> :TestLast<cr>

"
" NERDTree
"
:nmap <Leader>t :NERDTreeToggle<CR>
:nmap <Leader>T :NERDTreeFind<CR>

"
" NERDCommenter
"
map <leader>/ <plug>NERDCommenterToggle<CR>

"
" Misc
"

packadd! dracula-theme
colorscheme dracula

" Allow backspace at start of insert http://blog.sanctum.geek.nz/vim-annoyances/
set backspace=indent,eol,start

" Remove trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

" Highlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Ignore certain file types
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Show line numbers
set nu

" Indent with 2 spaces
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" Incremental search
set incsearch

" Be smart about case sensitiveness
" | /copyright      " Case insensitive
" | /Copyright      " Case sensitive
" | /copyright\C    " Case sensitive
" | /Copyright\c    " Case insensitive
set smartcase

" Treat JST templates as HTML
au BufNewFile,BufRead *.jst* set filetype=html

" diff
set diffopt=filler,vertical

" NeoVim :terminal
:tnoremap <Esc> <C-\><C-n>

" No annoying backup/swap files all over the place
set backupdir=~/.config/nvim/backup/
set directory=~/.config/nvim/swp/

" Markdown settings (builtin)
autocmd BufNewFile,BufReadPost *.md set filetype=markdown " *.md is Markdown, not Modula
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'ruby', 'javascript']

" Terminal
autocmd TermOpen * setlocal scrollback=100000

" Show 80-char column mark
set colorcolumn=80
