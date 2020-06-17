"
"
"
"
"
"           general settings only
"
"
"
"
"
"
"
"------------------------------------------------------


"----------------ui presentation--------------------------------
"font
set guifont="Powerline\ 15"

"scroll by c-u,c-d
set scroll=7
set scrolloff=9999

"preventing window size changes for side panes
"doesnt shrink side windows(vista,nerdtree)
"shrinks the main page instead
set noequalalways

"----------------background--------------------------------
"filetype detection
filetype on
filetype plugin on

"allow plugin indent
filetype plugin indent on

"lsp general settings
set completeopt+=menuone,noselect,noinsert
set completeopt-=preview
set shortmess+=c  
