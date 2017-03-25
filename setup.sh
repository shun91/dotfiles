#!/bin/sh

### 各ファイルにsymlinkをはる ###
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global

# 可能な場合はremoteリポジトリはssh化しておく（push時にpass等の入力を省略できる）
cd ~/dotfiles
git remote set-url origin git@github.com:shun91/dotfiles.git

# ~/.zshrc_localが存在しなければ作成
if [ ! -e ~/.zshrc_local ]; then
  touch ~/.zshrc_local
fi

### .gitconfig生成（user設定が端末で異なるためgit管理しない） ###
cat << 'EOS' > ~/.gitconfig
[core]
  editor = vim
[alias]
  tree = log --graph --all --format=\"%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s\"
[core]
  excludesfile = ~/.gitignore_global
EOS
# gitのuser設定を促すメッセージを表示する
echo '### git user settings! ###'
echo 'git config --global user.name "user"'
echo 'git config --global user.email "email"'
