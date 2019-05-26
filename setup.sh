#!/bin/sh

############################################################################
### 複数回実行されたら困る処理を書かないこと！！！                       ###
### FIXME: 複数回実行を許す処理を初めの1回だけの処理でファイルを分けたい ###
############################################################################

# 各 dotfile のシンボリックリンク作成
# FIXME: リポジトリ内の dotfile を自動で取得できるようにしたい
# ------------------------------------------------------------------------------
ln -snf ~/dotfiles/.zshrc ~/.zshrc
ln -snf ~/dotfiles/.vimrc ~/.vimrc
ln -snf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -snf ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -snf ~/dotfiles/.gitconfig ~/.gitconfig

# remote リポジトリの ssh 化
# ------------------------------------------------------------------------------
cd ~/dotfiles
git remote set-url origin git@github.com:shun91/dotfiles.git

# ~/.zshrc_local が存在しなければ作成
# ------------------------------------------------------------------------------
if [ ! -e ~/.zshrc_local ]; then
  touch ~/.zshrc_local
fi

# ゴミ箱ディレクトリ作成 (rm するとこのディレクトリへ mv される)
# ------------------------------------------------------------------------------
mkdir -p ~/.Trash

# vscode の設定ファイルのシンボリックリンク作成
# ------------------------------------------------------------------------------
\rm -rf ~/Library/Application\ Support/Code/User
ln -s ~/dotfiles/vscode/User ~/Library/Application\ Support/Code/User

# zsh plugin のインストール
# ------------------------------------------------------------------------------
# zsh-autosuggestions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
