# QEMU仮想化テンプレート
## ファイル構成
- `linux/`: Linux(WSL, Mac)用のスクリプトのディレクトリ
- `win/`: Windows(PowerShell用のスクリプト)のディレクトリ
    - `format.*`
        - 仮想ドライブの作成およびフォーマットスクリプト
        - 初期設定および仮想ドライブのリセット時に使用する
    - `install.*:` 
        - 仮想環境へのOSインストールスクリプト
        - フォーマット後や再インストール時に使用する
        - ISOファイルをマウントすること以外は`run.*`と同じ
    - `run.*`
        - 仮想環境の起動スクリプト
        - OSインストール完了後に使用する
- `.env`
    - 全体共有の設定ファイル
    - 各スクリプトの最初に読み込む
    - 設定項目はコメントを要確認

## 前提ライブラリの導入
- Windows
https://www.qemu.org/download/#linux
- Mac 
https://www.qemu.org/download/#macos
- Linux
https://www.qemu.org/download/#linux

## 基本的な使い方
### インストール
1. Ubuntuの[ISOファイル](https://www.ubuntulinux.jp/download/ja-remix)をダウンロード
1. このリポジトリのルートにダウンロードしたISOファイルを設置
1. ISOのファイル名を`ubuntu.iso`に変更
1. `win/`および`linux/`以下に移動
    - `win`
    - `linux`
        1. `bash format.bash`
            - `{リポジトリルート}/machine/ubuntu.qcow2`が生成されます
        1. `bash install.bash`
            - Ubuntuのインストールに関しては各々で調べてください
        1. `bash run.bash`

- SSHはインストール後`7022`ポートにアクセスしてください

### リセット
- 初期設定と同様に`format.*`と`install.bash`を実行する
- `format.*`を実行した時点で仮想ドライブの中身が消えるため、**要バックアップ**

### カスタマイズ
- 上記ではUbuntuを用いていますが、設定ファイルを修正すれば他のLinuxディストリビューションも実行可能です
- ポートフォワーディングのやり方は各々調べてください
    - `run.*`と`install,*`を書き換える必要があります

## 検索ワード
- QEMU
    - ポートフォワーディング
- 仮想ドライブ
    - qcow2
- Linuxディストリビューション
