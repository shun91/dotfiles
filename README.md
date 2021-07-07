dotfiles
========

## 管理しているもの

- いわゆる dotfiles
- VSCode の設定 (拡張機能は含めない)
- iTerm2 の設定 ([参考](https://qiita.com/reoring/items/a0f3d6186efd11c87f1b))

## インストール
```
cd
git clone https://github.com/shun91/dotfiles.git
sh ~/dotfiles/setup.sh
```

必要に応じて `~/.gitconfig_ghe` も作成する。

## dotfilesを変更した時
```
cd ~/dotfiles
git add .
git commit -m "commit msg."
git push -u origin master
```

## 変更したdotfilesを同期する
```
cd ~/dotfiles
git pull
sh ~/dotfiles/setup.sh # 必要があれば
```

## zshに独自の設定を追加したい場合
`~/.zshrc_local`に設定を追加すれば良い。
（`~/.zshrc`の最後で`~/.zshrc_local`が読み込まれるようになっている）

## 参考URL
http://qiita.com/okamos/items/7f5461814e8ed8916870
