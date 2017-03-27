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

" プラグインリストを収めた TOML ファイル
let g:rc_dir    = expand('~/.vim/rc')
let s:toml      = g:rc_dir . '/dein.toml'
let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml, s:lazy_toml])

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

"======================
" neosnippet settings
" tomlに書くと何故か動かないので、ここに書いている
"======================

" スニペットが選択されてる場合、Enterキーで展開
imap <expr><CR> neosnippet#expandable() <bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? neocomplcache#smart_close_popup() : "\<CR>"

"======================
" Vim default settings
"======================

" タブ切り替えに関する設定
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_zeSID_PREFIX$')
endfunction
" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first indow, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示
" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n.' :tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

" ファイルタイプがhtml,xml,eruby,phpの時、閉じタグを自動補完
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype php inoremap <buffer> </ </<C-x><C-o>
augroup END
autocmd! FileType eruby,html,markdown,xml,php setlocal omnifunc=htmlcomplete#CompleteTags

" 行末の空白文字をハイライト
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" 拡張子が.mdをmarkdownとして扱う
autocmd BufRead,BufNewFile *.md set filetype=markdown

" python, php編集時はtabのサイズを4に
autocmd FileType python,php setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

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
" タブ入力時に何文字の半角スペースに変換するか
set softtabstop=2
" ヘルプの言語
set helplang=ja,en
" カレント行の強調表示をon
set cursorline
" 行末から次行の先頭に、行頭から前行の末に移動可能に
set whichwrap+=h,l,<,>,[,],b,s
" ステータラインを下から2行目に表示
set laststatus=2
" 入力中のコマンドを右下に表示
set showcmd
" Insertモード中に<BS>で直前の文字を消せるように
set backspace=indent,eol,start
" vimのクリップボードとシステムのクリップボードを同期
set clipboard+=unnamed
" カラースキーマの指定
colorscheme molokai
" 80 桁目に印を付ける
set colorcolumn=80
" マクロやコマンドを実行する間、画面を再描画しない(スクロールが重くなる対策)
set lazyredraw
" 高速ターミナル接続を行う(スクロールが重くなる対策)
set ttyfast
" insertモードのみマウス操作を有効化（ドラッグ&コピーしづらいので）
set mouse=i
" マウス操作を高機能にする
set ttymouse=xterm2
" 改行時の自動インデントをon
set smartindent
" シンタックスハイライトをon
syntax on
