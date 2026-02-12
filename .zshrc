# プロファイル計測時にコメントアウトを外す
# zmodload zsh/zprof

###############################################################################
# 雑多な設定

# PATH
PATH="/usr/local/bin:/opt/homebrew/bin:/usr/bin:/usr/local/sbin:$HOME/bin:$HOME/.local/bin:$PATH"

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
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
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
alias nr="npm run"

# rmはmvのエイリアスとする → claude codeでrm実行が難しくなるので、rmtに変更
alias rmt='rm_to_mv'
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
# マージ済みブランチ一括削除
# https://qiita.com/hajimeni/items/73d2155fc59e152630c4
alias gbdm='git delete-merged-branch'
# Squash mergeされたブランチ一括削除
# https://github.com/not-an-aardvark/git-delete-squashed#sh
alias gbdms='TARGET_BRANCH=main && git checkout -q $TARGET_BRANCH && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base $TARGET_BRANCH $branch) && [[ $(git cherry $TARGET_BRANCH $(git commit-tree $(git rev-parse $branch\^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout main || git checkout master'
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
alias gst='git stash'
alias gsts='git stash save'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'
alias gstc='git stash clear'
alias gcp='git cherry-pick'
alias gr='git rebase -i'

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

# cmd + shift + ; で拡大するために必要
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

###############################################################################
# Git Worktree作成→セットアップ→VS Codeまでワンコマンドで実施
# Usage: gwn <branch-name>
function gwn() {
  local name=$1

  if [[ -z "$name" ]]; then
    echo "Error: Branch name is required."
    echo "Usage: gwn <branch-name>"
    return 1
  fi

  # Gitルートディレクトリを取得
  local git_root
  git_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -z "$git_root" ]]; then
    echo "Error: Not a git repository."
    return 1
  fi

  # 元のディレクトリを記憶
  local original_dir="$PWD"

  # リポジトリ名を取得
  local repo_name
  repo_name=$(basename "$git_root")

  # ワークツリーの親ディレクトリ (../repo_name.worktrees)
  local worktree_base="$(dirname "$git_root")/${repo_name}.worktrees"
  
  # 作成するワークツリーのパス
  local target_path="$worktree_base/$name"

  echo "🚀 Setting up worktree for '$name'..."
  echo "   Location: $target_path"

  # 1. worktreeの作成 (既存ブランチならcheckout、新規なら-b作成)
  if git show-ref --verify --quiet "refs/heads/$name"; then
    echo "Existing branch found. Checking out..."
    git worktree add "$target_path" "$name"
  else
    echo "Creating new branch..."
    git worktree add -b "$name" "$target_path"
  fi

  if [[ $? -ne 0 ]]; then
    echo "❌ Failed to create worktree."
    return 1
  fi

  # 2. 設定ファイルのコピー
  echo "📄 Copying configuration files..."
  
  # .env ファイル群のコピー
  setopt localoptions nullglob
  for env_file in "$git_root"/.env*; do
    local filename=$(basename "$env_file")
    if [[ ! -f "$target_path/$filename" ]]; then
      cp "$env_file" "$target_path/"
      echo "   Copied: $filename"
    else
      echo "   Skipped: $filename (already exists)"
    fi
  done

  # .claude/settings.local.json のコピー
  if [[ -f "$git_root/.claude/settings.local.json" ]]; then
    mkdir -p "$target_path/.claude"
    if [[ ! -f "$target_path/.claude/settings.local.json" ]]; then
      cp "$git_root/.claude/settings.local.json" "$target_path/.claude/"
      echo "   Copied: .claude/settings.local.json"
    else
      echo "   Skipped: .claude/settings.local.json (already exists)"
    fi
  fi

  # 3. 依存関係のインストール (一時的にディレクトリ移動して実行)
  cd "$target_path" || return 1

  echo "📦 Detect package manager and installing dependencies..."
  if [[ -f "pnpm-lock.yaml" ]]; then
    echo "   Detected: pnpm"
    pnpm install
  elif [[ -f "yarn.lock" ]]; then
    echo "   Detected: yarn"
    yarn install
  elif [[ -f "bun.lockb" ]]; then
    echo "   Detected: bun"
    bun install
  elif [[ -f "package-lock.json" ]]; then
    echo "   Detected: npm"
    npm install
  else
    echo "⚠️ No lock file found. Skipping installation."
  fi

  # 4. VS Codeで開く
  echo "💻 Opening in VS Code..."
  if command -v code >/dev/null 2>&1; then
    code .
  else
    echo "⚠️ 'code' command not found. Please install 'code' command in PATH."
  fi

  # 5. 元のディレクトリに戻る
  cd "$original_dir"
  echo "✅ Worktree setup complete!"
  echo "   path: $target_path"
}

###############################################################################
# 以下は最後に実行

# PC毎のzshrcの読込
source ~/.zshrc_local

# 最後にパスを通す
export PATH

# プロファイル計測時にコメントアウトを外す
# zprof