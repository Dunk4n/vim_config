let $MYPWD =expand('<sfile>:p:h')

"command:
command Getsrc read !find src -name "*.c" | sed  's/$/		\\/g'

"script
source $MYPWD/script/template.vim

syntax on
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
autocmd BufNewfile *.hpp :Stdheader
autocmd BufNewfile *.cpp :Stdheader
autocmd BufNewfile *.c :Stdheader
autocmd BufNewfile *.h :Stdheader
"template
autocmd BufNewFile *.hpp 0r $MYPWD/templates/hpp.template
"expand template
autocmd BufNewfile *.hpp :TemplateExpand
