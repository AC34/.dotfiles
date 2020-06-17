"
"
"
"
"
"           plugin settings only
"
"
"
"
"
"
"
"------------------------------------------------------
"----------------color theme--------------------------------
"color theme
colorscheme falcon "air-line use powerline fonts"

"----------------airline--------------------------------
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

"----------------nerdtree--------------------------------
"nerdtree width
let g:NERDTreeWinSize=30

"-----------------ale-------------------------------
"ale setting
" disable linting while typing
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 0
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
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'

"-----------------vim-lsp-------------------------------
"vim-lsp
let g:lsp_fold_enabled = 0
let g:lsp_diagnostics_enabled =  0
let g:lsp_signs_enabled = 1        " enable signs
let g:lsp_diagnostics_echo_cursor = 0 " enable echo under cursor when in normal mode
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼', 'icon': '/path/to/some/icon'} " icons require GUI
let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'} " icons require GUI
let g:lsp_highlights_enabled = 1
let g:lsp_textprop_enabled = 1
let g:lsp_virtual_text_enabled = 1
let g:lsp_highlight_references_enabled = 1

"-----------------asyncomplete-------------------------------
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_remove_duplicates = 1

"-----------------utilsnips-vim-lsp------------------------------
"utilsnips for vim-lsp
if has('python3')
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
        \ 'name': 'ultisnips',
        \ 'whitelist': ['*'],
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \ }))
endif

"-----------------vista------------------------------
let g:vista_icon_indent = ["╰─ ", "├─ "]
let g:vista#renderer#enable_icon = 1
let g:vista_executive_for = {
  \ 'php': 'vim_lsp',
  \ }



