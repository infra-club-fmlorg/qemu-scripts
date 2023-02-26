# QEMU仮想化テンプレート
## Windows利用者方へ
Windowsではシェルスクリプトの実行が面倒な為、PowerShellのスクリプトを用意する予定です。
しかし、WSLを活用することでLinuxやMacと共通のスクリプトを実行できるため、こちらを推奨します。

また、必ず[Windows Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=ja-jp&gl=jp)をインストールし、これ経由でPowerShellやWSLを起動してください。
### WSL
Windowsが標準で提供しているLinux仮想環境です。
今回の課題では仮想環境(WSL)の中に仮想環境(QEMU)を作る形になります。
### WSLのインストール
- Windows11
    PowerShell上で以下のコマンドを実行するだけです。
    ```bash
    wsl --install Ubuntu
    ```
- Windows10
    [Microsoft公式ドキュメント](https://learn.microsoft.com/ja-jp/windows/wsl/install-manual)

## WSLを使用しない場合
### Winget[Microsoft公式ドキュメント](https://learn.microsoft.com/ja-jp/windows/package-manager/winget/)
    
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
- Windows(WSLを使用しない場合)
    1. QEMUのインストール
        PowerShell
        ```powershell
        winget install git
        winget install qemu
        ```
    1. QEMUのパスを通す
        Wingetでは自動でパスまで通してくれることが多い(Gitなど)のですが、QEMUは手動で追加する必要があります。
        `C:\Program Files\qemu`をWindowsのPathに追加しましょう。

        ※Winget以外でのインストールや、今後の変更でインストール先のパスが変わる可能性があります。
- Mac 
    [QEMU公式](https://www.qemu.org/download/#macos)
    ```bash
    brew install qemu git curl
    ```
- Linux(WSL)
    [QEMU公式](https://www.qemu.org/download/#linux)
    ```bash
    sudo add-apt-repository ppa:canonical-server/server-backports
    sudo apt update
    sudo apt install -y qemu-system git curl
    qemu-system-x86_64 --version
    ```

## 基本的な使い方
### インストール
1. リポジトリのクローン
    ```bash
    cd
    git clone https://github.com/infra-club-fmlorg/qemu-scripts.git
    cd qemu-scripts
    ```
1. Ubuntuの[ISOファイル](https://www.ubuntulinux.jp/download/ja-remix)をダウンロード
    ```bash
    # サイズが大きいので注意
    curl -L -o ubuntu.iso ubuntu-ja-22.04-desktop-amd64.iso（ISOイメージ）
    ```
1. `win/`および`linux/`以下に移動
    - `win`
        作成予定
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
- WSL
    - WSLg
    - Hyper-V
