# QEMU仮想化テンプレート
## M1(M2) Macの利用者へ
aarch64の動作は軽快ですが、x86_64のエミュレーションは非常に低速です(GUIありのOSインストールに半日以上)。
x86_64の仮想化が必要であれば、他のx86_64マシンの使用を推奨します。

## Windows利用者へ
Windowsではシェルスクリプトの実行が面倒な為、PowerShellのスクリプトを用意する予定です。
しかし、WSLを活用することでLinuxやMacと共通のスクリプトを実行できるため、こちらを推奨します。

また、必ず[Windows Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=ja-jp&gl=jp)をインストールし、これ経由でPowerShellやWSLを起動してください。

### WSL
Windowsが標準で提供しているLinux仮想環境です。
今回の課題では仮想環境(WSL)の中に仮想環境(QEMU)を作る形になります。

[WindowsでWSL2を使って「完全なLinux」環境を作ろう！](https://www.kagoya.jp/howto/it-glossary/develop/wsl2_linux/)

### WSLのインストール
- Windows11

    PowerShell上で以下のコマンドを実行するだけです。
    ```bash
    wsl --install Ubuntu
    ```
- Windows10

    [Microsoft公式ドキュメント](https://learn.microsoft.com/ja-jp/windows/wsl/install-manual)

## WSLを使用しない場合
### Winget
[Winget](https://apps.microsoft.com/store/detail/%E3%82%A2%E3%83%97%E3%83%AA-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%A9%E3%83%BC/9NBLGGH4NNS1?hl=ja-jp&gl=jp&rtc=1)

[Microsoft公式ドキュメント](https://learn.microsoft.com/ja-jp/windows/package-manager/winget/)
    
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

        ```powershell
        winget install git
        winget install qemu
        ```
    1. QEMUのパスを通す

        Wingetでは自動でパスまで通してくれることが多い(Gitなど)のですが、QEMUは手動で追加する必要があります。
        `C:\Program Files\qemu`をWindowsのPathに追加しましょう。

        ※Winget以外でのインストールや、今後の変更でインストール先のパスが変わる可能性があります。

        [Windows 10の環境変数に PATH を追加する方法](https://anykey.bz/program/win10-path/)
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
1. Ubuntuの[ISOファイル](https://www.ubuntulinux.jp/download/ja-remix)のダウンロード

    ```bash
    # サイズが大きいので注意
    curl -L -o ubuntu.iso http://cdimage.ubuntulinux.jp/releases/22.04/ubuntu-ja-22.04-desktop-amd64.iso
    ```
1. `win/`および`linux/`以下に移動
    - `win`
        作成予定
    - `linux`
        1. `bash format.bash`(初回起動時のみ)
            - `{リポジトリルート}/machine/ubuntu.qcow2`が生成されます
        1. `bash install.bash`(初回起動時のみ)
            - Ubuntuのインストールに関しては各々で調べてください
        1. `bash run.bash`(二回目以降の起動)
1. SSHでホストマシンから接続

    [Ubuntu 20.04 - SSHのインストールと接続方法](https://codechacha.com/ja/ubuntu-install-openssh/)

    ホストマシンからSSHする場合は以下のようになります。
    ```bash
    ssh {username}@localhost -p 7722
    ```

### リセット
- 初期設定と同様に`format.*`と`install.bash`を実行する
- `format.*`を実行した時点で仮想ドライブの中身が消えるため、**要バックアップ**

### カスタマイズ
- 初期設定では仮想マシンの占有リソースをCPU2コア、RAM4GBと抑えているので、GUIありだと割と遅いです
    - 設定ファイルを書き換えるか、[サーバ用インストーラ](https://releases.ubuntu.com/22.04.2/ubuntu-22.04.2-live-server-amd64.iso?_ga=2.26803450.695035561.1677387518-1689776431.1671630457)でGUIなしにすると動作が軽快になります
- 上記ではUbuntuを用いていますが、設定ファイルを修正すれば他のLinuxディストリビューションも実行可能です
- 以下のポートフォワーディングがデフォルトで設定されています
    - `7722:22`、`7780:80`
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
