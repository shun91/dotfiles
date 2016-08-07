"=====================
" Start dein settings
"=====================

if &compatible
  set nocompatible
endif

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
" if dein#check_install()
"   call dein#install()
" endif


"========================
" Neocomplcache settings
"========================

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" カーソル移動で作動しないようにする。
let g:neocomplcache_enable_insert_char_pre = 1
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
  endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

"=====================
" neosnippet settings
"=====================

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
 
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
 
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" 自作 snippet ファイルのパス
let g:neosnippet#snippets_directory = '~/.vim/snippets/'


"============================
" vim-indent-guides settings
"============================

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=234
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1


"=======================
" vim-quickrun settings
"=======================

let g:quickrun_config = {
\   "_"    : {
\       'split' : 'botright 8sp'
\   },
\   "html" : {
\				'command' : 'open',
\				'exec' : '%c %s',
\				'outputter' : 'error',
\				'outputter/error/success' : 'null'
\   },
\   "markdown" : {
\       'command' : 'PrevimOpen',
\       'exec' : '%c',
\       'outputter' : 'browser',
\   }
\}


"=================
" previm settings
"=================

let g:previm_open_cmd = 'open'

"=======================
" vim-autopep8 settings
"=======================

function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
    call Preserve(':silent %!autopep8 -')
endfunction

autocmd FileType python nnoremap <S-f> :call Autopep8()<CR>

"=======================
" tyru/caw.vim settings
"=======================

" コメントの追加・削除を行なう
nmap <Leader>/ <Plug>(caw:zeropos:toggle)
vmap <Leader>/ <Plug>(caw:zeropos:toggle)

"===================
" NREDTree settings
"===================

" ブックマークを初期表示
let g:NERDTreeShowBookmarks=1

" 隠しファイルも表示
let NERDTreeShowHidden = 1

" ファイル名が指定されてVIMが起動した場合はNERDTreeを初期表示
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Ctrl+nでNERDTreeを表示
map <C-n> :NERDTreeToggle<CR>

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')

" ディレクトリ表示記号を変更する
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable  = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'

"======================
" Vim default settings
"======================

" ファイルタイプがhtml,xml,eruby,phpの時、閉じタグを自動補完
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype php inoremap <buffer> </ </<C-x><C-o>
augroup END
autocmd! FileType eruby,html,markdown,xml,php setlocal omnifunc=htmlcomplete#CompleteTags

" 拡張子が.mdをmarkdownとして扱う
au BufRead,BufNewFile *.md set filetype=markdown

" python編集時はtabのサイズを4に
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

" cmd+p でペースト時は自動的にpaste modeとなる
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"
 
    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction
 
    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

" インデント変更時はvisulal modeから抜けないようにする
vnoremap > >gv
vnoremap < <gv

" シンタックスハイライトをon
syntax enable
" 行番号表示をon
set number
" カーソル位置の右下表示をon
set ruler
" インクリメンタルサーチをon
set incsearch
" 検索語句のハイライトをon
set hlsearch
" 対応する括弧の1s間強調表示をon
set showmatch matchtime=1
" 検索時に大文字小文字を区別しない
set ignorecase
" 検索時に大文字小文字を区別しないのは、検索語句が全て小文字の時のみ
set smartcase
" コマンドラインの履歴の保存件数
set history=2000
" タブをスペースに自動変換
set expandtab
" タブの文字数
set tabstop=2
" 自動挿入されるインデントのスペース幅
set shiftwidth=2
" ヘルプの言語
set helplang=ja,en
" カレント行の強調表示をon
set cursorline
" 行末から次行の先頭に、行頭から前行の末に移動可能に
set whichwrap+=h,l,<,>,[,],b,s
" ステータラインを下から2行目に表示
set laststatus=2
" 改行時の自動インデントをon
set smartindent
" 入力中のコマンドを右下に表示
set showcmd
" Insertモード中に<BS>で直前の文字を消せるように
set backspace=indent,eol,start
" vimのクリップボードとシステムのクリップボードを同期
set clipboard+=unnamed
" カラースキーマの指定
colorscheme molokai

