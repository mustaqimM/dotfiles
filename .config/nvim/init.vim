if !exists('g:vscode')
" Has to be first
set nocompatible

call plug#begin('~/.nvim/plugged')
  "Plug 'ctjhoa/spacevim'
  "Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " NERD tree will be loaded on the first invocation of NERDTreeToggle command
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  "Plug 'bronson/vim-trailing-whitespace'
  "Plug 'vim-syntastic/syntastic'
  "Plug 'xolox/vim-misc'
  "Plug 'xolox/vim-easytags'
  "Plug 'majutsushi/tagbar'
  "Plug 'ctrlpvim/ctrlp.vim'                " Find files with <C-p>
  "Plug 'yuttie/comfortable-motion.vim'     " Smooth motion
  "Plug 'vim-scripts/a.vim'                 " Open the header file with :AT
  "Plug 'Raimondi/delimitMate'              " Automatic closing of quotes, parenthesis, brackets, etc.
  "Plug 'tpope/vim-surround'
  "Plug 'tpope/vim-commentary'
  "Plug 'Valloric/YouCompleteMe' ", { 'do': './install.py --clang-completer' }
  "Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
  "Plug 'jeaye/color_coded'               " libclang-based highlighting in C, C++, ObjC
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocomplete
  "Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
  "Plug 'sagarrakshe/toggle-bool'
  "Plug 'godlygeek/tabular'
  " ========== Git ==========
  "Plug 'airblade/vim-gitgutter'
  "Plug 'tpope/vim-fugitive'
  Plug 'chriskempson/base16-vim'
  "Plug 'joshdick/onedark.vim'
  "Plug 'itchyny/vim-cursorword'            " Underlines words under cursor

call plug#end()                     		" Add plugins to &runtimepath

" ===== Filetype Settings =====
filetype plugin indent on                 	" Enable file type detection. Tries to recognise filetype and load plugins and indent files
augroup myFiletypes
au!

" ========== General settings ==========
set termguicolors
set t_Co=256                        		" Enable 256 colours
set backspace=indent,eol,start              " allow backspacing over everything in insert mode
set ruler                         			" show the cursor position all the time
set number                          		" line numbers
set showcmd                       			" display incomplete commands
set showmatch                       		" highlight matching [{()}]
set incsearch                       		" do incremental searching
set mouse=a
set ttyfast                       			" make laggy connections work faster
set tabstop=4
set shiftwidth=4
set hlsearch
set colorcolumn=80

"Needed for plugins like Syntastic and vim-gitgutter which put symbols in the sign column.
hi clear SignColumn

" =========== Theme conf ===========
" Switch syntax highlighting on, when the terminal has colour
" Also switch on highlighting the last used search pattern.
let base16colorspace=256                  	" Access colors present in 256 colorspace
if &t_Co > 2 || has("gui_running")
  syntax enable
  set background=dark
endif

let g:enable_bold_font = 1                	" Make some functions bold

try
  colorscheme base16-tomorrow-night
catch
endtry

let g:airline_theme='tomorrow'

if (exists('colorcolumn'))                  " Right column at 80
  set colorcolumn=80
    highlight ColorColumn ctermbg=59
endif

" =========== vim-airline ===========
set laststatus=2                      		" Always show statusbar
let g:airline_detect_paste=1                " Show PASTE if in paste mode
let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#tabline#enabled = 1        " Displays all buffers when there's only one tab open.
let g:airline_powerline_fonts = 1

"autocmd vimenter * NERDTree

" === xolox/vim-easytags settings ===
" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" === majutsushi/tagbar settings ===
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
"autocmd BufEnter * nested :call tagbar#autoopen(0)   " Open tagbar automatically whenever possible

" === YouCompleteMe ===
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" === scrooloose/syntastic settings ===
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"

set statusline=%#warningmsg#
set statusline=%{SyntasticStatuslineFlag()}
set statusline=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['standard']    " Standard for Javascript

augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

" Use deoplete.
let g:python3_host_prog = "/usr/bin/python3"
let g:deoplete#enable_at_startup = 1

" === Raimondi/delimitMate settings ===
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" === Create File/Directories if it doesn't exist ===
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" === Search with FZF and rg
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" === Search with fzy and rg
function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction

" === Key Mappings ===
let mapleader = ","
let g:mapleader = ","
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
cmap w!! w !sudo tee > /dev/null %
map <C-n> :NERDTreeToggle<CR>
map <C-m> :SyntasticToggleMode<CR>
map gh 0
map gl $
map ; :
map! jj <ESC>
nmap <Leader>v :tabedit $MYVIMRC
nmap <Leader>s :source $MYVIMRC
nmap <F8> :TagbarToggle<CR>
noremap K :SuperMan <cword><CR>

:nmap ,p o<ESC>p

nnoremap <leader>e :call FzyCommand("fd -t f", ":e")<cr>
"nnoremap <leader>v :call FzyCommand("find -type f", ":vs")<cr>
"nnoremap <leader>s :call FzyCommand("find -type f", ":sp")<cr>

noremap <leader>r :ToggleBool<CR>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

endif
