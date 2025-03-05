set nocompatible
set encoding=utf-8


"
" Package management
" https://github.com/k-takata/minpac
"
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

call minpac#add('nvim-lua/plenary.nvim')
call minpac#add('nvim-telescope/telescope.nvim', {'rev': '0.1.x'})
call minpac#add('dracula/vim', {'name': 'dracula-theme'})
call minpac#add('rking/ag.vim')
call minpac#add('scrooloose/nerdtree')
call minpac#add('tpope/vim-rails')
call minpac#add('tpope/vim-sensible')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('vim-scripts/spacehi.vim') " Highlight trailing spaces
call minpac#add('kassio/neoterm')
call minpac#add('vim-test/vim-test')
call minpac#add('tpope/vim-fugitive')
call minpac#add('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'})


"
" Adapted from https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
"
call minpac#add('williamboman/mason.nvim')
call minpac#add('williamboman/mason-lspconfig.nvim')
call minpac#add('neovim/nvim-lspconfig')
call minpac#add('simrat39/rust-tools.nvim')

" Completion framework
call minpac#add('hrsh7th/nvim-cmp')

" LSP completion source:
call minpac#add('hrsh7th/cmp-nvim-lsp')

" Useful completion sources:
call minpac#add('hrsh7th/cmp-nvim-lua')
call minpac#add('hrsh7th/cmp-nvim-lsp-signature-help')
call minpac#add('hrsh7th/cmp-vsnip')
call minpac#add('hrsh7th/cmp-path')
call minpac#add('hrsh7th/cmp-buffer')
call minpac#add('hrsh7th/vim-vsnip')

lua require("setup/mason")
lua require("setup/rust-tools")
lua require("setup/lsp-diagnostics")
lua require("setup/completion")


command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()

"
" Telescope
"
:nmap <C-p> <cmd>lua require('telescope.builtin').find_files()<CR>

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
