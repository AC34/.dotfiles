"Neovim setup (not gvim)
"Commenting
"preferrably all in lowercase (for quick searches)

"----------------ui presentation--------------------------------
"font
set guifont="Powerline\ 15"

"scroll by c-u,c-d
set scroll=7
set scrolloff=9999
"search highlight
augroup searchHighlight
  au BufEnter * execute "hi search ctermfg=179 ctermbg=NONE"
				     \| execute "hi Folded ctermfg=179 ctermbg=Black"
augroup END

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

"load keymap settings
source $HOME/.config/nvim/keymaps.vim

"load plugin keymap
source $HOME/.config/nvim/plugin_keymaps.vim

"load plugin settings
source $HOME/.config/nvim/plugins.vim


"----------------neovim related settings--------------------------------
"----------------gvim related settings--------------------------------
"----------------windows related settings--------------------------------
