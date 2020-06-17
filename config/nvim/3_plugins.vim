"
"
"
"
"
"           plugin installation settings only
"
"
"
"
"
"
"
"------------------------------------------------------

"vim-plug
call plug#begin("~/.config/nvim/plugged/")

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

"colors in source code
Plug 'chrisbra/colorizer'
"introduction screen
Plug 'mhinz/vim-startify'

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
" multiple languages syntax
Plug 'sheerun/vim-polyglot'
" tagbar alternative
Plug 'liuchengxu/vista.vim'
"auto lsp settings
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
"auto completion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
"php requires composer(globally installed PHPMD,PHPCS,PHPSTAN)
Plug 'w0rp/ale'
"snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'

"----------------bash
"bash folding
Plug 'demophoon/bash-fold-expr'

"----------------markdown
"----------------dockerfile
"----------------html
" emmet
"Plug 'mattn/emmet-vim'
"----------------css
"----------------php
"using intelephense requires npm install -g intelephense
"updated syntax file
Plug 'StanAngeloff/php.vim', {'for': 'php'}
"php coding standard fixer
Plug 'friendsofphp/php-cs-fixer'

call plug#end()

