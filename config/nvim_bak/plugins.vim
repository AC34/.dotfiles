"vim-plug
call plug#begin()


"----------------ui presetnation--------------------------------
"color theme
Plug 'fenetikm/falcon'

" powerline like status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"icons
Plug 'ryanoasis/vim-devicons'

"NERDTree
Plug 'scrooloose/nerdtree'
"nerd tree git status highlight as it says
Plug 'scrooloose/nerdtree-git-plugin'

"----------------genral--------------------------------
" vim-scaffold
Plug 'AC34/Vim-scaffold'
" do def if end word competion
Plug 'tpope/vim-endwise'
" close bracket, quotes
Plug 'Townk/vim-autoclose'


"----------------git--------------------------------
"git +- indicator left to line number
Plug 'airblade/vim-gitgutter'
" got commands
Plug 'tpope/vim-fugitive'


"----------------languages--------------------------------
"
"----------------lnaguages general
" emmet
Plug 'mattn/emmet-vim'
" multiple languages syntax
Plug 'sheerun/vim-polyglot'
" tagbar alternative
Plug 'liuchengxu/vista.vim'
"auto commpletion
Plug 'ncm2/ncm2'

"Asynchronous Lint Engine
"php requires composer(globally installed PHPMD,PHPCS,PHPSTAN)
Plug 'w0rp/ale'

"----------------bash
"bash folding
Plug 'demophoon/bash-fold-expr'

"----------------markdown
"----------------dockerfile
"----------------html
"----------------css
"----------------php
"updated syntax file
Plug 'StanAngeloff/php.vim', {'for': 'php'}
"completion candidates
Plug 'phpactor/phpactor', { 'do': ':call phpactor#Update()', 'for': 'php'}
"to work with ncm2
Plug 'phpactor/ncm2-phpactor', {'for': 'php'}
"php coding standard fixer
Plug 'friendsofphp/php-cs-fixer'
"document fixer
Plug 'Rican7/php-doc-modded'

call plug#end()


"----------------plugin-settings--------------------------------
"color theme
colorscheme falcon "air-line use powerline fonts"

let g:airline_powerline_fonts = 1
"show buffers at the top of the screen
let g:airline#extensions#tabline#enabled=1
"show tab number
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme="deus"

"use airline symbols
if !exists("g:airline_symbols")
  let g:airline_symbols={}
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

"nerdtree width
let g:NERDTreeWinSize=30

"ale setting
" disable linting while typing
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=0
let g:ale_list_window_size = 5
let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_php_phpmd_ruleset='phpmd.xml'
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'php': ['phpcbf', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
  \}
let g:ale_fix_on_save = 1

"phpactor executable path
let g:phpactor_executable = '~/.config/nvim/plugged/phpactor/bin/phpactor'
