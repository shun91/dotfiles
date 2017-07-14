"======================
" Vim default settings
"======================

" ファイルタイプがhtml,xml,eruby,php,js,vueの時、閉じタグを自動補完
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype php inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype javascript inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype vue inoremap <buffer> </ </<C-x><C-o>
augroup END
autocmd! FileType eruby,html,markdown,xml,php,javascript,vue setlocal omnifunc=htmlcomplete#CompleteTags

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

" PHPファイル保存時に自動シンタックスチェック
augroup PHP
  autocmd!
  autocmd FileType php set makeprg=php\ -l\ %
  " php -lの構文チェックでエラーありの場合のみ、エラーが表示される
  autocmd BufWritePost *.php silent make | if len(getqflist()) != 1 | copen | else | cclose | endif | redraw!
augroup END

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
set cindent
" シンタックスハイライトをon
syntax on
