#!/bin/sh

### 各ファイルにsymlinkをはる ###
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

### .gitconfig生成（user設定が端末で異なるためgit管理しない） ###
cat << 'EOS' > ~/.gitconfig
[core]
  editor = vi
[alias]
  tree = log --graph --all --format=\"%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s\"
EOS
# user設定を促すメッセージを表示する
echo ‘git user settings!’
echo 'git config --global user.name "user"'
echo 'git config --global user.email "email"'
