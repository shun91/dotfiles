###############################################################################
# 雑多な設定

# PATH
PATH="/usr/local/bin:/usr/bin:/usr/local/sbin:/Users/kawahara/bin:$PATH"

# Macの場合のみ、php7.1にパスを通す
# 予め `brew install homebrew/php/php71` をしておくこと！
case ${OSTYPE} in
  darwin*) # Mac用の設定
    PATH="$(brew --prefix homebrew/php/php71)/bin:$PATH"
    ;;
esac

# Add Visual Studio Code (code)
PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# 言語設定
export LC_CTYPE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
unset LC_ALL

# コマンドヒストリの保持数をデフォルトより多くする
HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=9999

# コマンドの'#' 以降をコメントとして扱う
setopt interactive_comments

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# 明確なドットの指定なしで.から始まるファイルをマッチ
setopt globdots

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

# vimにctrl-zで戻る
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

###############################################################################
# plugins

# zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

###############################################################################
# 見た目の設定

# 色を使用出来るようにする（プロンプトのユーザ名等の色変更に必要）
autoload -Uz colors
colors

# lsのディレクトリ色をマゼンタに
export LSCOLORS=Exfxcxdxbxegedabagacad

# vcs_info（gitのブランチ名などの表示）
# 参考：http://tkengo.github.io/blog/2013/05/12/zsh-vcs-info/
autoload -Uz vcs_info # vcs_infoを読み込む
zstyle ':vcs_info:git:*' check-for-changes true # commit済かなどのチェック
zstyle ':vcs_info:*' formats "%F{green}%c%u(%b)%f" # 基本の表示フォーマット
zstyle ':vcs_info:git:*' unstagedstr "%F{red}a" # addしてないファイルがある
zstyle ':vcs_info:git:*' stagedstr "%F{red}c" # commitしてないファイルがある
zstyle ':vcs_info:*' actionformats '%F{yellow}(%b|%a)' # conflictなどが起こった時
precmd () { vcs_info } # vcs_infoを実行
setopt prompt_subst # vcs_infoの内容を表示するのに必要

# プロンプト表示のフォーマット
PROMPT='%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~ ${vcs_info_msg_0_}
$ '

###############################################################################
# alias設定

# よく使うやつ
alias la='ls -la'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias grep='grep --color' # 色つける
alias esl='exec $SHELL -l'

# rmはmvのエイリアスとする
alias rm='rm_to_mv'
function rm_to_mv() {
  command mv $1 ~/.Trash/
}

# OS別の設定
case ${OSTYPE} in
  darwin*) # Mac用の設定
    # lsの色設定はMacとLinuxで異なる
    alias ls='ls -FG'
    # vim（brewでいれたやつ）
    alias vi='/usr/local/bin/vim'
    ;;
  linux*) # Linux用の設定
    # ファイルタイプ別に色を付ける
    alias ls='ls -F --color=auto'
    ;;
esac

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# Git Aliases
alias g='git'
alias ga='git add'
alias gaa='git add .'
alias gb='git branch'
alias gbd='git branch -d '
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gcod='git checkout develop'
alias gd='git diff'
alias gl='git log'
alias gm='git merge --no-ff'
alias gpl='git pull'
alias gplo='git pull origin'
alias gps='git push'
alias gpso='git push origin'
alias gpsom='git push origin master'
alias gpsod='git push origin develop'
alias gss='git status -s'

# ファイル内検索エイリアス
alias fgrep='find ./ -type f -print | xargs grep'

###############################################################################
# 補完設定

# gitのサブコマンド等の補完機能を有効にする
autoload -Uz compinit
compinit -C # 起動時間短縮のため、セキュリティチェックをskip

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

###############################################################################
# 以下は最後に実行

# PC毎のzshrcの読込
source ~/.zshrc_local

# 最後にパスを通す
export PATH
