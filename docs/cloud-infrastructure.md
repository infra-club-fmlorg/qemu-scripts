class: center, middle
# クラウド基盤入門編
深町研究室

土田快斗

---
# クラウドネイティブの時代
## クラウドが大前提
- IaaS、PaaS、SaaS etc…
- AWS、Azure、GCP、OCI、Heroku etc…

現在では色々なクラウドサービスが提供されている

そしてこれらを上手く組み合わせて使っていくのが、いわゆるモダンな開発

自前で細かいところの管理をする必要がなくて色々と楽

---
# しかもなんとなく使える
最近のクラウドサービスは非常に便利なので、細かいところまで勉強せずとも活用できる

## 例えばデータベースを立てようとすると…

- サーバの購入
- OSのインストール
- DBMS本体のインストール
- パスワードや公開ポートの設定
- バックアップの設定
etc...

## AWSのRDSなら！
- WebのUIに従って入力

内部の初期設定からバックアップまで全部よしなにやってくれる…

---
# 勉強しなくても大丈夫では？
## 現実は…
![求められているのはスーパーヒーロー](https://github.com/infra-club-fmlorg/qemu-scripts/blob/main/docs/image/superhero.png?raw=true)

.small[[【今更聞けない】Linuxのしくみ - Forkwell Library #16](https://www.youtube.com/watch?v=Il6JLfJIV9E)より引用]


専門ではなくても概要程度は掴んでおく必要があります。

---
# どんな技術が使われているのか
重要なのは**仮想化**です。
Dockerのようなコンテナ技術も仮想化に含まれています。

