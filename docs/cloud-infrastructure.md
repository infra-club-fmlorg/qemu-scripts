class: center, middle
.title[
# クラウド基盤入門編

深町研究室

土田快斗
]

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

## AWSのRDSなら！
- WebのUIに従って入力

## 裏側では(多分)
データベースインストール済みのイメージを使って、EC2のインスタンスを生成

---
# しかもなんとなく使える
## オンプレミスでデータベースサーバを立てようとすると…
- サーバの購入
- OSのインストール
- DBMS本体のインストール

etc...

---
# 使えるなら勉強しなくても大丈夫では？
## 現実は…
.center[
![求められているのはスーパーヒーロー](./image/superhero.png)

.small[[【今更聞けない】Linuxのしくみ - Forkwell Library #16](https://www.youtube.com/watch?v=Il6JLfJIV9E)より引用]
]

---
# 某動画サービスのフロントエンドでは
[フロントエンドが色々やっています](https://dwango.github.io/nicolive-kubernetes-migration-handbook-2022/docs/network/architecture/)

.center[
![ニコニコのネットワーク](https://dwango.github.io/nicolive-kubernetes-migration-handbook-2022/docs/network/kubernetes-network.svg)

]

---
# 求められる能力が高い！
- 流石に全部極めるのは無理(10年後、20年後でやっと？)
- どんな技術で成立しているのかぐらいは知る必要がある
    - トラブルシューティングができない
        - クラウド？アプリケーション？データベース？それ以外？
        - 障害になり得る点が複雑に絡んでる
    - 環境特有の制限とかアンチパターンがあったりする
        - 再帰処理で実行回数がとんでもないことに→100万円請求

---
class: center, middle
# クラウドではどのような技術が使われているのか
重要なのは**仮想化**と**冗長化**

---
# 仮想化って？
今回研修で使ってもらう`QEMU`(ホスト型)はこんな感じ

.center[
![ホスト型](https://www.itmanage.co.jp/column/virtualization-server-integration/img/img_host.png)

.small[[ホスト・ハイパーバイザー・コンテナの違いとは？](https://www.itmanage.co.jp/column/virtualization-server-integration/)より引用]
]
---
# 種類はいくつかある
`EC2`はこんな感じ(`XEN`(ハイパーバイザー型)というを使ってる)

.center[
![ハイパーバイザー型](https://www.itmanage.co.jp/column/virtualization-server-integration/img/img_hypervisor.png)

.small[[ホスト・ハイパーバイザー・コンテナの違いとは？](https://www.itmanage.co.jp/column/virtualization-server-integration/)より引用]
]

---
# コンテナ技術も仮想化の一種
`Docker`(コンテナ型)はこんな感じ

`Paas`(Heroku)や`FaaS`(AWS Lambda)はコンテナベース

.center[
![コンテナ型](https://www.itmanage.co.jp/column/virtualization-server-integration/img/img_container.png)

.small[[ホスト・ハイパーバイザー・コンテナの違いとは？](https://www.itmanage.co.jp/column/virtualization-server-integration/)より引用]
]

---
# なぜクラウドで仮想化技術が使われるのか
- 一つのマシンで色々やりたい
    - 一人一台サーバだとスケーリングとかやってられない
- 他の人や他のシステムの影響を受けたくない
    - CPUは共有されてるケースが多い
    - OSやディスクは分割されている
- バックアップや移行を簡単にしたい
    - イメージや仮想ドライブをコピーすれば簡単に複製可能

---
# 仮想化技術の重要性
- クラウドだけでなく、オンプレミスでもほとんど仮想化してる
    - 実はみんなのWindowsも多分`Hyper-V`で仮想化されてる
    - `VMware`とか`Proxmox`とかが有名
- 簡単に作って壊せるから効率的に開発・運用できる
    - コンテナは特にこの傾向が強い
    - よく聞くKubernatesはコンテナを効率よく関する仕組み
        - 全部コードで定義できる(いわゆるIaCの一種)
        - 自動で作ったり壊したり、落ちたら再起動したり
- 開発マシンの違いを誤魔化せるので、チーム開発で非常に有効

---
# 今回の研修でクラウドを使わない理由
- クラウドって意外と高いので、可能なら研究室サーバ使っていこうという宣伝
- 3/2現在、AWSの`t3.large`インスタンスは`0.1088USD/h`で月1万円ぐらい、スペックはあまり高くない(4コア8GBとか)
- 年12万で5年運用したら60万
- 保守費用とか諸々考えて採用する必要がある
- 開発環境とか落ちても大丈夫なら研究室のサーバを使おう！
- 大事なサービスはクラウドの方が安心できる
    - 冗長化まで自前でやるのは難しい

---
# 環境壊れるのが怖いです…
仮想化していれば大丈夫！

EC2のようにサーバに直接仮想環境を作ってもいいですが、今回はもっと手軽に手元のマシンでも仮想環境作れるので、作って壊して色々試してみましょう

システムが仮想環境で動いたら、そのまま研究室サーバに移植してみよう


