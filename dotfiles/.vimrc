""#!!!!!!!使い始める前に!!!!!!!!!!!!!!!!!
"
"vimのバージョンによって、翔えきる機能にtががある
"vim --versionで機能の一覧を表示えきる
"clipboardなどをチェックする




"#-----------------keymap-------------------------------

"map <Esc> to fd
imap fd <Esc>
"disalbe space from any binding
nnoremap <Space> <NOP>
"leader key
let g:mapleader = "\<Space>"

"open nerdtree by leader+e
map <Leader>e :NERDTreeToggle<CR>

"close with leader ke
nmap <Leader>c :close<CR>

"scroll up and down with leader key
nmap <Leader>u <C-u>
nmap <Leader>d <C-d>

"keep the  curser position centered
"nnoremap j jzz
"nnoremap k kzz
"nnoremap b bzz
"nnoremap h hzz
"nnoremap l lzz
"nnoremap a zza 
"nnoremap n nzz
"nnoremap N Nzz
"nnoremap <C-u> <C-u>zz
"nnoremap <C-d> <C-d>zz

"toggle zen mode
nnoremap <Leader>f :Goyo<CR>

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
set encoding=utf-8

"wrap lines
"set wrap

"autoindention always on
set autoindent

"allow plugin indent
filetype plugin indent on

"shit width by spaces
set shiftwidth=4

"tab by shiftwidth at the beginning of the line
set smarttab 

"set 2 psaces for a tab
set tabstop=2

"highlight on search
set hlsearch

"set font
set guifont=Powerline\ 14

"enable mouse
set mouse=a

"keyboard repeat rate can be set at .bashrc
"e.g. xset r rate 250 45 means 250 delay, 45 chars/sec

"scroll lines by, for c-u,c-d
set scroll=7

"set cursor centered while scrolling
"this can be active for mouse too
set scrolloff=99999


"#-----------------plugin-------------------------------
"vim-plug
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

"updat ctags automatically
Plug 'ludovicchabant/vim-gutentags'

"list buffers
Plug 'jeetsukumaran/vim-buffergator'

"powerline like theme
Plug 'vim-airline/vim-airline-themes'

"git
Plug 'tpope/vim-fugitive'

"taglist
Plug 'vim-scripts/taglist.vim'

"zen mode
Plug 'junegunn/goyo.vim'

"keep cursor at fixed line
Plug 'vim-scripts/scrollfix'

"autocompletion
"vim-plug specific setting
":neovim_rpc#serveraddr() to check if there is no error (1 is ok)
"require python3 to run, and pip3 aliased to  python and pip
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

"syntax checker
"syntax checkers are:
"https://github.com/vim-syntastic/syntastic/blob/master/doc/syntastic-checkers.txt
Plug 'scrooloose/syntastic'


cal plug#end()
"#-----------------Plugin settings----------------------

"set colorscheme
colorscheme falcon

"air-line use powerline fonts
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"テーマの設定"vim-airline-theme"は別のプラグイン
"ここで選ぶhttps://github.com/vim-airline/vim-airline/wiki/Screenshots
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

"scroll fix setting
 let g:scrollfix=50  " means middle line of screen "

"#-----------------augroup genral----------------

"General Settings
augroup general
		"override search highlight colors
		"can only take 15 colors or NONE
		"here making highlights don't interfere theme colors
		au BufEnter * execute "hi Search ctermfg=NONE ctermbg=233" 		
augroup END


"#-----------------augroup text----------------
".txt files only

augroup general
		".txt files only
		au BufEnter *.txt,*.text execute "hi Search ctermfg=179"
		au BufEnter *.txt,*.text call SearchAndHighlightText()
augroup END

function! SearchAndHighlightText()
		"this can be really diverse
		let l:exp = "let @/ = \'"
		"for #
		let l:exp .= "\\(^\\n\\)\\@<=\\s*#.*\\n\\(.*#.*\\)\\@<!"
		let l:exp .= "\\|"
		"for "
		let l:exp .= "\\(^\\n\\)\\@<=\\s*\".*\\n\\(.*\".*\\)\\@<!"
		let l:exp .= "\\|"
		"for !
		let l:exp .= "\\(^\\n\\)\\@<=\\s*\!.*\\n\\(.*\!.*\\)\\@<!"
		let l:exp .= "\\|"
		"a line starting with number plus some characters like "." "," space ":" ";"
		let l:exp .= "^\\(\\d\\+\\)\\(\.\\|\\,\\|\\s\\|\:\\|\;\\).*\\n"
		let l:exp .= "\\|"
		"paragraphs after empty line trailing empty line
		let l:exp .= "\\(^\\n\\)\\@<=.*\\n"
		"end of the regex
		let l:exp .= "\'"
		execute l:exp
endfunction

"#-----------------augroup todos----------------
"todo file specific settings
augroup todos
		"clear autocmd histories
		autocmd!
		"search for # at boot
		au BufEnter *.todo,todo execute "let @/ = '\^#.*\\n'" | execute "normal! n"
		"change 
	  au BufEnter *.todo,todo execute "hi search ctermfg=179 ctermbg=NONE"

augroup END

"#-----------------augroup vimrc----------------
"vimrc specific settings
augroup vimrc
		"clear autocmd histories
		autocmd!
		"override theme color 	
  	au BufEnter *.vimrc execute "hi Search ctermfg=193 ctermbg=233" 		
		"search for # at boot, and place cursor at there
		"to search multiple patterns, have \\| between each words
		au BufEnter *.vimrc execute "let @/ = '\".*-\\n'" | execute "normal n"
augroup END

"#-----------------augroup configs(config,.config)----------------
"things like i3config .config/i3/config

augroup configs
		autocmd!
		au BufEnter config,.config,*.conf execute "hi Search ctermfg=193 ctermbg=233" 
		"Search lines starting with #
		au BufEnter config,.config,*.conf call SearchAndHighlightConfigs()
augroup END

function! SearchAndHighlightConfigs()
		"almost the same as text but not expecting natural language
		let l:exp = "let @/ = \'"
		"for #
		let l:exp .= "\\(^\\n\\)\\@<=\\s*#.*\\n\\(.*#.*\\)\\@<!"
		let l:exp .= "\\|"
		"for "
		let l:exp .= "\\(^\\n\\)\\@<=\\s*\".*\\n\\(.*\".*\\)\\@<!"
		let l:exp .= "\\|"
		"for !
		let l:exp .= "\\(^\\n\\)\\@<=\\s*\!.*\\n\\(.*\!.*\\)\\@<!"
		"end of the regex
		let l:exp .= "\'"
		execute l:exp
endfunction


"#-----------------augroup .desktop----------------

".desktop files
augroup desktop
		autocmd!
		"catching entry section delimiting line
		"e.g. [Desktop Entry]
		au BufEnter .desktop execute "let @/ = \'^\\(\\[\\).*\\]\\n\'"
augroup END


"#-----------------augroup .gitconfig----------------
"gitconfig specific

augroup gitconfig
		autocmd!
		"Serach lines by gitconfig sections
		au BufEnter .gitconfig execute "let @/ = '\^\\(\\s*\\[\\|\\[\\).*\\].*\\n'" | execute "normal n"
augroup END



"#-----------------augroup .gitignore----------------

augroup gitignore
		autocmd!
		"coloring by gold
		au BufEnter .gitignore execute "hi Search ctermfg=136 ctermbg=233"
		"serach lines by comments
		au BufEnter .gitignore execute "let @/ = '\^\\(^\\n\\)\\@<=#.*\\(\\n#\\)*.*\\n\\(#\\)\\@!'" | execute "normal n"

augroup END


"#-----------------augroup sources.list(/etc/apt/sources.list) ----------------
"debian and its derivatives

augroup sourceslist
		autocmd!
		"coloring by gold
		au BufEnter sources.list execute "hi Search ctermfg=136 ctermbg=233"
		"similar to bash
		au BufEnter sources.list execute "let @/ = '\^\\(^\\n\\)\\@<=#.*\\(\\n#\\s\\)*.*\\n\\(#\\s.*\\)\\@!'" | execute "normal n"
augroup END

"#-----------------augroup bash(.sh,.bash.bashrc)----------------
"bash and sh settings
augroup bash
		autocmd!
		au BufEnter *.sh,*.bash,.bashrc execute "hi Search ctermfg=193 ctermbg=233"
		"escaping \ needs to be escaped \\
		"positive lookbehind is \@<=
		"startsWith # can be done with  \^#
		"basically searching for new paragraph of bash comment preceeded by empty line(\n)
		au BufEnter *.sh,*.bash,.bashrc execute "let @/ = '\^\\(^\\n\\)\\@<=#.*\\(\\n#\\)*.*\\n\\(#\\)\\@!'" | execute "normal n"
		
augroup END

"#-----------------augroup php----------------

"php settings
augroup php
		autocmd!
		"highlight classes,functions,methods,interfce
		au BufEnter *.php call SearchAndHighlightPHP()
augroup END

function! SearchAndHighlightPHP()
  "double backslashes are treated as \ when execute is called
  "@/ registers history of last search pattern
	"single quote must be escapd ' => \'
	let l:exp = "let @/ =\'"
  "search class declaration (with and without preceeding whitespaces and tabs.)
  let l:exp .= "^\\(class\\|\\s*class\\)\\s.*\\n"."\\|"
  "serach interfface declaration
	let l:exp .= "^\\(interface\\|\\s*interface\\)\\s.*\\n"."\\|"
	"search for plain functions
  let l:exp .= "^\\(function\\|\\sfunction\\)\\s,*\\n"."\\|"	
	"search for methods within classes and functions 
	let l:exp .= "^\\s*\\(public\\|private\\|protected\\)\\sfunction.*\\n"
	"end by adding single quote
  let l:exp .= "\'"
  execute l:exp
endfunction

"#-----------------augroup xml----------------

augroup xml
 
augroup END

function! SearchAndHighlightXML()
  
  "start replacing here
  "start of the regex 
	let l:exp = "let \@ = \'"	
	"highlight up to level 2
	"let l:exp .= "^\\(<\\|\\s<)".l:depth.".*\\n" 
	"depth 1
	let l:exp .= "^\\<.*\\n" 
	"depth 2
	let l:exp .= "\\|"."\\s*"
  "end of the regex
	let l:exp .= "\'"
	"execute regex highlight
  execute l:exp	
endfunction
"#-----------------augroup xhtml----------------
augroup xhtml

augroup END

"#-----------------augroup html5----------------
"for html tags only
augroup html5
		
augroup END

"#-----------------augroup css3----------------
"for pure css3 only
augroup css3

		
augroup END

"#-----------------augroup json(.json)----------------
augroup json

		
augroup END

"#-----------------augroup javascript(.js)----------------
augroup javascript
		autocmd!
		"highlight important lines	
		au BufEnter *.js execute SearchAndHighLightJS()
augroup END
function! SearchAndHighLightJS()
		
		"start by single quote
		let l:exp = "let @/ = \'"
		"new operator for creating instance and assignment
		let l:exp .= ".*=\\s*new.*(.*\\n" 
		"declaration of functions with assignments 
		"e.g. const|let|var|window.onload = function 
		let l:exp .= "\\|".".*\\(const\\|let\\|var\\|.*\\.\\).*\=\\s*function.*\\n"
		"declaration of plain function
		let l:exp .= "\\|"."^\\(\\s*function\\|function\\).*\\n"
		"declaration of annonymous functions with brackets
		let l:exp .= "\\|".".*(.*function.*(.*).*\\n"
		"declaration of annonymous functions with assignments
		let l:exp .= "\\|"."^\\(const\\|let\\|var\\|.*\.\\).*\=>.*\\n"
		"close by adding single quote
		let l:exp .=	"\'"	
		"execute regex
		execute l:exp
endfunction

"#-----------------Function (CountIndentSpacesMultiplierUnit)----------------
"Tries to find number of spaces per depth
"returns value of 0~n
function! CountIndentSpacesMultiplierUnit()
	 "starting from 1
	 "load file as list
   let l:lines = readfile(expand('%:t'))	
	 "let l:lines = readfile("./double_indents.txt") "lines

	 "list of preceeding spaces and occurances count
   let l:occurances = {} "dictionary
	 
	 "for later use, make sum of odd/even numbers
	 let l:sum_odds = 0
	 let l:sum_evens = 0

   "count the occurances of the spaces of each lines
	 for line in l:lines
     "count number of preceeding spaces as indent
		 let l:spaces = matchend(line,"\\(\\s\\)\\@!")
		 "initialie
		 if has_key(l:occurances,l:spaces) ==# 0 | let l:occurances[l:spaces] = 0 | endif

		 if l:spaces > 0
		   "count up if dividable and l:spacesis greater than 0
		   let l:occurances[l:spaces] += 1
			 "debug
		   "echo "counted as [".l:spaces."][".line."]"
		 endif

		 "countup odds/evens
		 if l:spaces % 2 ==# 0 && l:spaces > 0
				 let l:sum_evens += 1
		 else
				 let l:sum_odds += 1
		 endif 
   endfor
	 echo "first loop end, occurances=".len(l:occurances)


	 "Little special treatment on cardinal number 1
   "When all the occurances of odd/even numbers are "ALMOST" the "same",
	 "both nubers of spaces might be equally distributed all over the text.
	 "When this is happening, no right strategy can be performed.
	 "There can be a special cardinal number which is 1 in this case.
	 "This can also work when both are zero.
	 ""ALMOST" highlhy depends on personal preference.
	 "lets identify abs less than quarter as within "same" range.
   let l:almost = 0.25
   let l:is_same = abs(sum_odds - sum_evens) < sum_odds*l:almost
   "debug
	 echo "odds[".l:sum_odds."] evens[".l:sum_evens."]"
	 echo "distribution. abs[".abs(sum_odds - sum_evens)."] range=[".float2nr(sum_odds*l:almost)."]"
	 "imeediately end the process and return 1
	 if l:is_same | echo "!!!same!!!" | endif
	 if l:is_same | return 1 | endif


	 "debug show collected lines
	 for spaces in keys(l:occurances)
			 echo "occurances[".spaces."] =".l:occurances[spaces]
   endfor
	 
	 "incremental assumption numbers of the actual composite space numbers
	 "0 will be meaning less
	 "1 always wins, thus should be kept only as reference later
	 "hence starting with 2
	 let l:base = 2
	 let l:base_max = len(l:occurances)
	 "picking numbers only available for making a multiplier
	 let l:scores = copy(l:occurances)
	 while l:base <= l:base_max
			"loop through the data again for scoring
		 	for spaces in keys(l:occurances)
				"only if spaces can be divided by base(incremental spaces
				"and if space> l:base
				if (str2nr(spaces) % l:base) ==# 0 && spaces > l:base
					"initialize if key doesn't exist
					if has_key(l:scores,l:base) ==# 0 | let l:scores[l:base] = 0 | endif
					  "add only if spaces(actually existing in file) can be divided(by
					  "assumption by simple incrementation)
					  "no exact double counts allowed
					  let l:scores[l:base] += l:occurances[spaces]
				endif "dividable only
		  endfor
		  "increment base
			let l:base += 1
	 endwhile 

   "keep this as reference for later evaluation
	 "0 if key isn't found
   let l:scores["1"] = has_key(l:occurances,"1") ? l:occurances["1"] : 0

	 "debug: show current list
	 for spaces in keys(l:scores)
		 echo "scores[".spaces."] =".l:scores[spaces]
   endfor

   "now find the highest space number by comparison withmax value
	 let l:max_score = max(l:scores)
	 echo "max_score=".l:max_score
	 for spaces in keys(l:scores)
		 if l:scores[spaces] ==# l:max_score
		   let highest_spaces_unit = spaces
     endif
   endfor

   "finally return
   return l:highest_spaces_unit
endfunction

"#-----------------Function (CountTotalLineNumbers)----------------
"Counts the number of linefeeds
function! CountTotalLineNumbers()
		let l:ln = execute("\%s\/\\n\/\/gn")
		return l:ln
endfunction

function! FileAsList()
		
endfunction
