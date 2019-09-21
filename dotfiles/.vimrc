"#!!!!!!!使い始める前に!!!!!!!!!!!!!!!!!
"vim ;-versionで機能の一覧を表示できる
"clipboardなどをチェックする
"Pluginの管理
".vimrcを開いて　:source % :PlugInstallで入れる":PlugInstallだけでうまくいかない場合は、PlugUpdateも追加で試す

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
"#-----------------background parts---------------------
"linux unnamedplus, windows unnamed
set clipboard=unnamedplus

"encoding for when writing files

set fileencoding=utf-8

"no swap file
set noswapfile

"set undo times
set undolevels=500

"set history counts
set history=500

"filetype detection on 
filetype on

"allow highlights during typing
set incsearch

"#-----------------visible parts------------------------
"show line numbers
set number

"enable256 colors when terminal supports
set t_Co=256

"visible parts of the editor
set encoding=utf-8"wrap lines
set wrap

"autoindention always on
set autoindent"allow plugin indent
filetype plugin indent on

"set 2 spaces for a tab
set tabstop=2"shit width by spaces
set shiftwidth=0 "with 0 follows tabstop
set softtabstop=-1 "follows shiftwidth

"tab by shiftwidth at the beginning of the line
set smarttab "highlight on search
set hlsearch

"set font
set guifont=Powerline\ 15"enable mouse
set mouse=a

"keyboard repeat rate can be set at .bashrc

"e.g. xset r rate 250 45 means 250 delay, 45 chars/sec"scroll lines by, for c-u,c-d
set scroll=7

"set cursor centered while scrolling

"this can be active for mouse too
set scrolloff=21

"#-----------------plugin vim-plug-------------------------------"

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

"icons
"needs to install compatible font(e.g. NerdFonts)
Plug 'ryanoasis/vim-devicons'

"updat ctags automatically
Plug 'ludovicchabant/vim-gutentags'

"list buffers
Plug 'jeetsukumaran/vim-buffergator'

"powerline like theme
Plug 'vim-airline/vim-airline-themes'

"git
Plug 'tpope/vim-fugitive' "taglist

"taglist
Plug 'vim-scripts/taglist.vim'

":neovim_rpc#serveraddr() to check if there is no error (1 is ok)
"require python3 to run, and pip3 aliased to  python and pip

Plug 'Shougo/deoplete.nvim'

Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

"syntax checker

"syntax checkers are:

"https://github.com/vim-syntastic/syntastic/blob/master/doc/syntastic-checkers.txt
Plug 'scrooloose/syntastic'

"snippet
Plug 'shougo/neosnippet.vim'


"icons
"Plug ''


Plug 'ac34/vim-scaffold'

call plug#end()

"#-----------------plugin settings----------------------"set colorscheme

colorscheme falcon "air-line use powerline fonts

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"テーマの設定"vim-airline-theme"は別のプラグイン

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

"taglist
set tags=tags
"give ctags path
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
"show only tags of current viewing file
let Tlist_Show_One_File = 1
"right window
let Tlist_Use_Right_Window = 1
"if there's only taglist window currently opening, then exit vim
let Tlist_Exit_OnlyWindow = 1

"vim-scaffold settings
let g:scaffold_mode = 1
"autoindent setting
let g:scaffold_autoindent_enable = 1 
let g:scaffold_autoindent_maxcount = 500
"auto highlight setting
let g:scaffold_autohi_enable = 1
let g:scaffold_leaderhighlight_enable = 1 
"auto folding setting
let g:scaffold_autofold_enable = 1
let g:scaffold_overridejumps_enable = 1
let g:scaffold_showcolumn_enable = 1

"#-----------------augroup searchHighlight----------------
augroup searchHighlight
  au BufEnter * execute "hi search ctermfg=179 ctermbg=NONE"
augroup END


