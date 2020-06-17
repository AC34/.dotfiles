"
"
"
"
"
"           general autocmd settings only
"
"
"
"
"
"
"
"------------------------------------------------------

"----------------general--------------------------------


"----------------ui--------------------------------
"search highlight
augroup searchHighlight
  au BufEnter * execute "hi search ctermfg=179 ctermbg=NONE"
				     \| execute "hi Folded ctermfg=179 ctermbg=Black"
augroup END

