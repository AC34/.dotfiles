"
"
"
"
"
"           plugin keymap settings only
"
"
"
"
"
"
"
"------------------------------------------------------
"----------------nerdtree--------------------------------
"nerdtree toggle by leader+e
" NERDTreeToggle does not care about the width
nnoremap <silent> <expr> <Leader>e g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

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

"----------------vista--------------------------------
"vista(tagbar alternative supports lsp)
nnoremap <silent> <Leader>v :Vista!!<CR>


"----------------asyncompletion--------------------------------
"asyncompletion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <c-space> <Plug>(asyncomplete_force_refresh)


"----------------vim-lsp-utilsnips--------------------------------
let g:UltiSnipsExpandTrigger="<c-e>"
