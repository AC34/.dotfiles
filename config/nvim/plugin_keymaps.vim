
"nerdtree toggle by leader+e
" NERDTreeToggle does not care about the width
nnoremap <silent> <expr> <Leader>e g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

"vista
nnoremap <silent> <Leader>w :Vista!!<CR>


"php modify
"nnoremap <leader>pm :call PHPModify("implement_contracts")<cr>

"bufexplorer in horiozontal window
nnoremap <Leader>b <Leader>b


"toggle and untoggle(without NERDTreeToggle()(so that tts window does not
"shrink))
function NTToggle()
  if g:NERDTree.IsOpen()==1
			 "closing
				:NERDTreeClose<CR>
		else
				:NERDTree<CR>
  endif
endfunction
