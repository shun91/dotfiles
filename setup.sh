### 各ファイルにsymlinkをはる ###
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global

### preztoのインストール ###
git clone --recursive https://github.com/shun91/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# 可能な場合はremoteリポジトリはssh化しておく（push時にpass等の入力を省略できる）
cd ~/dotfiles
git remote set-url origin git@github.com:shun91/dotfiles.git
cd ~/.zprezto
git remote set-url origin git@github.com:shun91/prezto.git

### .gitconfig生成（user設定が端末で異なるためgit管理しない） ###
cat << 'EOS' > ~/.gitconfig
[core]
  editor = vim
[alias]
  tree = log --graph --all --format=\"%x09%C(cyan bold)%an%Creset%x09%C(yellow)%h%Creset %C(magenta reverse)%d%Creset %s\"
[core]
  excludesfile = ~/.gitignore_global
EOS
# user設定を促すメッセージを表示する
echo '### git user settings! ###'
echo 'git config --global user.name "user"'
echo 'git config --global user.email "email"'
