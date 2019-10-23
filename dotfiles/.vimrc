"!!!!!!!使い始める前に!!!!!!!!!!!!!!!!!
"vim ;-versionで機能の一覧を表示できる
"clipboardなどをチェックする
"Pluginの管理
".vimrcを開いて　:source % :PlugInstallで入れる":PlugInstallだけでうまくいかない場合は、PlugUpdateも追加で試す
"間違ってwindowsで開いてしまった場合に終了
if has("win32")
	echom ".vimrc loaded on windows. use _vimrc."
	finish
endif

"#-----------------keymap-------------------------------

"map <Esc> to fd
imap fd <Esc>
"disalbe space from any binding
nnoremap <Space> <NOP>
"leader key
let g:mapleader = "\<Space>"

"open nerdtree by leader+e
map <Leader>e :NERDTreeToggle<CR>
"close Window with leader + c
nmap <Leader>c :close<CR>

"moves between windows
nnoremap <A-j> <C-W><C-j>
nnoremap <A-k> <C-W><C-k>
nnoremap <A-l> <C-W><C-l>
nnoremap <A-h> <C-W><C-h>

"scroll up and down with leader key
nmap <Leader>u <C-u>
nmap <Leader>d <C-d>

"enable highlight
nnoremap <Leader>h :set hls<CR>

"folding
"fold/unfold current part
"nmap Z za
nnoremap <S-h> za
nnoremap <S-l> za

"toggle buffer list
nnoremap <Leader>b :BuffergatorToggle<CR>

"tagbar
nnoremap <Leader>l :TagbarToggle<CR>
"toggle docker tool
nnoremap <A-d> :DockerToolsToggle<CR>

"jump between folds by tab
nnoremap <Tab> zj
nnoremap <S-tab> zk

"#-----------------background parts---------------------
"filetype detection on 
filetype on
"filetype plugin on 
filetype plugin on

"#-----------------visible parts------------------------
"allow plugin indent
filetype plugin indent on

"set font
set guifont=Powerline\ 15"enable mouse

"e.g. xset r rate 250 45 means 250 delay, 45 chars/sec"scroll lines by, for c-u,c-d
set scroll=7

"this can be active for mouse too
set scrolloff=21

"#-----------------plugin vim-plug-------------------------------"
"for windows
if empty(glob(
    \ '$HOME/' . (has('win32') ? 'vimfiles' : '.vim') . '/autoload/plug.vim'))
  execute '!curl -fLo ' .
    \ (has('win32') ? '\%USERPROFILE\%/vimfiles' : '$HOME/.vim') . 
    \ '/autoload/plug.vim --create-dirs ' .
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"write plugs between begin and end
call plug#begin()

"color theme
Plug 'fenetikm/falcon'

"powerline like looks
Plug 'vim-airline/vim-airline'

"color themes for airline
Plug 'vim-airline/vim-airline-themes'

"NERDTree
Plug 'scrooloose/nerdtree'
"nerd tree git status highlight as it says
Plug 'scrooloose/nerdtree-git-plugin'

"needs to install compatible font(e.g. NerdFonts)
Plug 'ryanoasis/vim-devicons'

"update ctags automatically
Plug 'ludovicchabant/vim-gutentags'

"list buffers
Plug 'jeetsukumaran/vim-buffergator'

"powerline like theme
Plug 'vim-airline/vim-airline-themes'

"git
Plug 'tpope/vim-fugitive' 
Plug 'airblade/vim-gitgutter' "sign column diff signgs

"tagbar
Plug 'majutsushi/tagbar'

":neovim_rpc#serveraddr() to check if there is no error (1 is ok)
"require python3 to run, and pip3 aliased to  python and pip

Plug 'Shougo/deoplete.nvim'

Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

"https://github.com/vim-syntastic/syntastic/blob/master/doc/syntastic-checkers.txt
Plug 'scrooloose/syntastic'

"neo snippet
Plug 'shougo/neosnippet.vim'
Plug 'shougo/neosnippet-snippets'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

"Vim Outliner
Plug 'vimoutliner/vimoutliner'

"cd into the proejct directory automatically(by git and etc)
"using as a project manager
Plug 'airblade/vim-rooter'

"use tab to select completion list
Plug 'ervandew/supertab'

"task runners
"thin vertical lines on each indents
Plug 'yggdroot/indentline'

"test units runner
"grunt
"https://vimawesome.com/plugin/grunt-vim
Plug 'mklabs/grunt.vim'
"gulp :Gulp to run
"https://vimawesome.com/plugin/gulp-vim
Plug 'kabbamine/gulp-vim'

"docker
"https://vimawesome.com/plugin/vim-docker-tools
Plug 'kevinhui/vim-docker-tools'
"docker file
Plug 'ekalinin/dockerfile.vim'

"automatically insert matching bracket
Plug 'raimondi/delimitmate'

"Language Specific plugins
Plug 'janko-m/vim-test'
"php
"php syntax
Plug 'StanAngeloff/php.vim'
"php-cs-fixer
Plug 'stephpy/vim-php-cs-fixer'
"syntax etc
Plug 'spf13/piv'
"php manual(Shift-k to see the manual)
Plug 'alvan/vim-php-manual'

"html
"xml and html folding
Plug 'vim-scripts/XML-Folding'
"emmet
Plug 'mattn/emmet-vim'

"bash
"bash folding
Plug 'demophoon/bash-fold-expr'


Plug 'ac34/vim-scaffold'

Plug 'ryanoasis/vim-devicons'

call plug#end()

"#-----------------plugin settings----------------------"set colorscheme

"set setting colorcheme
colorscheme falcon "air-line use powerline fonts

"テーマの設定"vim-airline-theme"は別のプラグイン

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"ここで選ぶhttps://github.com/vim-airline/vim-airline/wiki/Screenshots
"go the next line of current jump line
"vim-airline-theme is different plugin
"choose themes at:
"https://github.com/vim-airline/vim-airline/wiki/Screenshots
let g:airline_theme='deus'

"use airline symbols
if !exists('g:airline_symbols')
		let g:airline_symbols = {}
endif
"unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
"airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '' 
"deoplete
let g:deoplete#enable_at_startup = 1

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"tagbar width
let g:tagbar_width = 28

"nerdtree width
let g:NERDTreeWinSize=28

"buffergator width
let g:buffergator_split_size =28

"for neo snippet
let g:deoplete#enable_at_startup = 1


"vim-scaffold settings
let g:scaffold_mode = 1

"autoindent setting
"let g:scaffold_autoindent_enable = 1
"let g:scaffold_autoindent_maxcount = 500
"auto highlight setting
"let g:scaffold_autohi_enable = 1
"let g:scaffold_leaderhighlight_enable = 1
"auto foldcolumn setting
"let g:scaffold_autofoldcol_enable = 1

"#-----------------augroup searchHighlight----------------
augroup searchHighlight
  au BufEnter * execute "hi search ctermfg=179 ctermbg=NONE" 
				\|  execute "hi Folded ctermfg=179 ctermbg=Black"
augroup END
