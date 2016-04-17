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
if dein#check_install()
  call dein#install()
endif


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


"======================
" Vim default settings
"======================

" ファイルタイプがhtml,xml,eruby,phpの時、閉じタグを自動補完
autocmd FileType html inoremap <silent> <buffer> </ </<C-x><C-o>
autocmd FileType xml inoremap <silent> <buffer> </ </<C-x><C-o>
autocmd FileType php inoremap <silent> <buffer> </ </<C-x><C-o>
autocmd FileType eruby inoremap <silent> <buffer> </ </<C-x><C-o>

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
" カラースキーマの指定
colorscheme desert

