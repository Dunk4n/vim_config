let $MYPWD =expand('<sfile>:p:h')

set nocompatible
syntax enable
filetype plugin on
set path+=**
set wildmenu
command! MakeTags !ctags -R .
"autocomplete check :help ins-completion
"check :help netrw-browse-maps
"gh Quick hide/unhide of dot-files
let g:netrw_banner=0		" disable annoying banner
let g:netrw_browse_split=4	" open in prior window
let g:netrw_altv=1			" open split to the right
let g:netrw_liststyle=3		" tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"see :help key-notation
source $MYPWD/script/header.vim
let g:KeyToComplementaryFile = '<TAB>'
let g:FunctionForHeader = function("Add42Header")

"command:
command Getsrc read !find src -name "*.c" | sed  's/$/		\\/g'

"script
source $MYPWD/script/placeholders.vim
source $MYPWD/script/function.vim

set smartindent
set ruler
if exists('+colorcolumn')
	set colorcolumn=80
else
	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set cindent
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
set hlsearch
set backup
set backupdir-=.
set backupdir^=~/.saves,/tmp
set viminfo='20,<500
cnoreabbrev W w
cnoreabbrev Wq wq
au BufNewFile,BufRead *.s set filetype=nasm

"add header
"autocmd BufNewfile *.hpp :Stdheader
"autocmd BufNewfile *.cpp :Stdheader
"autocmd BufNewfile *.c :Stdheader
"autocmd BufNewfile *.h :Stdheader
"template
if expand('%:t') == 'main.cpp'
	autocmd BufNewFile main.cpp 0r $MYPWD/templates/main.cpp.template
else
	autocmd BufNewFile *.cpp 0r $MYPWD/templates/cpp.template
endif
if expand('%:t') == 'main.c'
	autocmd BufNewFile main.c 0r $MYPWD/templates/main.c.template
else
	autocmd BufNewFile *.c 0r $MYPWD/templates/c.template
endif
autocmd BufNewFile *.hpp 0r $MYPWD/templates/hpp.template
autocmd BufNewFile *.h 0r $MYPWD/templates/h.template
"expand template
autocmd BufNewfile *.hpp :TemplateExpand
autocmd BufNewfile *.cpp :TemplateExpand
autocmd BufNewfile *.h :TemplateExpand
autocmd BufNewfile *.c :TemplateExpand
