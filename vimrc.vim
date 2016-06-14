" echo 'source path/to/this/file' > ~/.vimrc
" e.g.
"   source d:/tzx/git/blog/vimrc.vim
"   set runtimepath+=d:/tzx/YouCompleteMe

let mapleader = ","
let g:mapleader = ","
map <leader>a ggVG
map <leader>o o<esc>S<esc>
map <leader>u :undolist<cr>
map <leader>file :echo expand("%:p")<cr>:let @+=expand("%:p")<cr>
" map <leader><leader> please don't map <leader><leader>
map <leader>wi vip :call Wikipedia()<cr>
map <leader>sp vip :call PanguSpacing()<cr>
map <leader>rs vipJ :call PanguSpacing()<cr> gqqo<esc>
map <leader>tc :call TitleCaseRegion()<cr>
map <leader>gq vipgq

"   if has("gui_win32")
"       let $TMP="d:/tzx/tmp"
"       let $TEMP="d:/tzx/tmp"
"   endif
"   set directory=.,$TMP,$TEMP

set nocompatible
set cursorline
set ruler
set backspace=indent,eol,start
set history=1000
set autoread
set showcmd
set incsearch                                               " do incremental searching
set ignorecase
set expandtab ts=4 sw=4 sts=4 ai
set path=.,/usr/include,~/dev/caffe-rc3,~/git/**
set isfname-=,
set isfname-==
" set lbr                                                     " linebreak
" set shortmess=atI                                           " :h iccf
set nu
set guioptions=""
set showmatch
set showfulltag
set matchpairs=(:),{:},[:],<:>
set matchtime=5                                             " Show matchtime in 0.5s
set mouse=""
set iskeyword-=_                                            " two words: twenty_one
" \u4e00-\u9fa5, \u3040-\u30FF
"  20223-40869,   12352-12543

set nobackup
set nowritebackup
set noswapfile

" nnoremap gz :!zeal --query '<cword>'&<CR><CR>

function! TitleCaseRegion()
    silent! '<,'>s/\v<(.)(\w*)/\u\1\L\2/g
endfunction
function! PanguSpacing()                                " :call PanguSpacing()
    silent! '<,'>s/\([\u4e00-\u9fa5\u3040-\u30FF]\)\([a-zA-Z0-9@#&=\[\$\%\^\-\+(\/\\]\)/\1 \2/g
    silent! '<,'>s/\([a-zA-Z0-9!#&;=\]\,\.\:\?\$\%\^\-\+\)\/\\]\)\([\u4e00-\u9fa5\u3040-\u30FF]\)/\1 \2/g
endfunction
function! PanguSpacingExtra()                           " :call PanguSpacingExtra()
    call PanguSpacing()
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\)\.\($\|\s\+\)/\1。/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\),\s*/\1，/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\);\s*/\1；/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\)!\s*/\1！/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\):\s*/\1：/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\)?\s*/\1？/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\)\\\s*/\1、/g
    silent! %s/(\([\u4e00-\u9fa5\u3040-\u30FF]\)/（\1/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\))/\1）/g
    silent! %s/\[\([\u4e00-\u9fa5\u3040-\u30FF]\)/『\1/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\)\]/\1』/g
    silent! %s/<\([\u4e00-\u9fa5\u3040-\u30FF]\)/《\1/g
    silent! %s/\([\u4e00-\u9fa5\u3040-\u30FF]\)>/\1》/g
endfunction

function! Wikipedia()
    silent! %s/\[\d\+\]//g "    "[23]" -> ""
endfunction

" set laststatus=2
" set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%h\ \ \ Line:\ %l

set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,cp936
set formatoptions=BmMcroql

map Q gq            " use Q for formatting

if has("gui_running")
    if has("gui_gtk2")
        set guifont=Inconsolata\ 12
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h14
    elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
    endif
endif

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
inoremap <C-z> <C-O>u           " Undo in insert mode
if version >= 703
    " Turn undofile on
    set undofile
    " Set undofile path
    set undodir=~/tmp/vim/
endif

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif
if has("autocmd")
    filetype plugin indent on
    augroup vimrcEx
        au!
        " autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
    augroup END
else
    set autoindent
endif " has("autocmd")

"if !exists(":DiffOrig")
"  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
"          \ | wincmd p | diffthis
"endif

"   source $VIMRUNTIME/mswin.vim
"
"       vnoremap <C-X> "+x
"       vnoremap <S-Del> "+x
"       vnoremap <C-C> "+y
"       vnoremap <C-Insert> "+y
"       map <C-V>       "+gP
"       map <S-Insert>      "+gP
"       cmap <C-V>      <C-R>+
"       cmap <S-Insert>     <C-R>+
"       exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
"       exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']
"       imap <S-Insert>     <C-V>
"       vmap <S-Insert>     <C-V>
"       noremap <C-Q>       <C-V>   " Use CTRL-Q to do what CTRL-V used to do
"       noremap <C-S>       :update<CR> " Use CTRL-S for saving, also in Insert mode
"       vnoremap <C-S>      <C-C>:update<CR>
"       inoremap <C-S>      <C-O>:update<CR>
"       " CTRL-A is Select all
"       noremap <C-A> gggH<C-O>G
"       inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
"       cnoremap <C-A> <C-C>gggH<C-O>G
"       onoremap <C-A> <C-C>gggH<C-O>G
"       snoremap <C-A> <C-C>gggH<C-O>G
"       xnoremap <C-A> <C-C>ggVG

" Delete trailing white space on save
func! DeleteTrailingWS()
    exe "normal mz"
    retab
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.* :call DeleteTrailingWS()

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>
vnoremap <silent> gv :call VisualSelection('gv')<CR>
vnoremap <silent> r :call VisualSelection('replace')<CR>
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

language messages en_US.utf-8

"set diffexpr="" MyDiff()
function MyDiff()
   let opt = '-a --binary '
   if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
   if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
   let arg1 = v:fname_in
   if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
   let arg2 = v:fname_new
   if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
   let arg3 = v:fname_out
   if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
   if $VIMRUNTIME =~ ' '
     if &sh =~ '\<cmd'
       let eq = '"'
       if empty(&shellxquote)
         let l:shxq_sav = ''
         set shellxquote&
       endif
       let cmd = '"' . $VIMRUNTIME . '\diff"'
     else
       let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
     endif
   else
     let cmd = $VIMRUNTIME . '\diff'
   endif
   silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
   if exists('l:shxq_sav')
     let &shellxquote=l:shxq_sav
   endif
endfunction

" silent execute NeoKbd()
function! NeoKbd()
    imap a b
    imap b s
    " a -> s
    " b -> s
endfunction
" so this won't work as expected
"
" instead, use `:set keymap=dvorak` (works only in insert mode)

ab rasa             refs and see also
ab fab              <i class="icon-book"></i>
ab facd             <i class="icon-cloud-download"></i>
ab faes             <i class="icon-exclamation-sign"></i>
ab faf              <i class="icon-flag"></i>
ab fah              <i class="icon-heart"></i>
ab fahe             <i class="icon-heart-empty"></i>
ab fais             <i class="icon-info-sign"></i>
ab falb             <i class="icon-lightbulb"></i>
ab fapp             <i class="icon-pushpin"></i>
ab fas              <i class="icon-star"></i>
ab fase             <i class="icon-star-empty"></i>
ab fat              <i class="icon-tag"></i>
ab fats             <i class="icon-tags"></i>
ab fatd             <i class="icon-thumbs-down"></i>
ab qwhudoc          http://whudoc.qiniudn.com/2016/
ab qgnat            http://gnat.qiniudn.com/
ab tbq              ```tzx-bigquote
