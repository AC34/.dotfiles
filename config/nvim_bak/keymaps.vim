"kemap settings only

"esct to fd
imap fd <Esc>
"disable space from any binding
nnoremap <Space> <NOP>

"set space as leader key
let g:mapleader= "\<Space>"

"close window with leader+c
nmap <Leader>q :close<CR>

nnoremap <C-h> <C-W><C-h>
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>

"resizing window size
"nnoremap <>:vertical resize -10
nnoremap <C-A>l:vertical resize +10

"scroll up and down with leader key
nmap <Leader>u <C-u>
nmap <Leader>d <C-d>

"fold/unfold current part
"nmap Z za
nnoremap <S-h> za
nnoremap <S-l> za

"jump between folds by tab
nnoremap <Tab> zj
nnoremap <S-tab> zk

"terminal
nnoremap <Leader>t :terminal --rows=6
