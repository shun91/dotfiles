###############################################################################
# 雑多な設定

# PATH
PATH="/usr/local/bin:/usr/bin:/usr/local/sbin:/Users/kawahara/bin:$PATH"

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

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

###############################################################################
# 見た目の設定

# 色を使用出来るようにする（プロンプトのユーザ名等の色変更に必要）
autoload -Uz colors
colors

# lsのディレクトリ色をマゼンタに
export LSCOLORS=Exfxcxdxbxegedabagacad

# プロンプト表示のフォーマット
PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "

# vcs_info（gitのブランチ名などの表示）
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'
function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

###############################################################################
# alias設定

# よく使うやつ
alias ls='ls -F'
alias la='ls -la'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# OS別の設定
case ${OSTYPE} in
  darwin*) # Mac用の設定
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
