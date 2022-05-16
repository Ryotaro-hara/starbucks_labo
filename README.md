# Starbucks　Labo

## 概要

Starbucks　Laboはstarbucks coffeeのドリンクの自分だけのお気に入りのカスタマイズをシェアしあえるコミニュティーサイトです。
仕事中や勉強中の一杯、頑張った時のご褒美の一杯、休日の朝の一杯。そんな一杯一杯が特別な一杯であって欲しい。そんな思いでサイトを作るに至りました。

*トップページ

![starbucks-labo1](https://user-images.githubusercontent.com/94495458/168611216-97ee655f-9258-4597-a319-fdd3db81f35c.png)

## 使い方

1.アカウント登録・ログイン
名前、メールアドレス、パスワードを設定する事でアカウントが作成できます。
ログインに関してはアカウント登録後メールアドレス・パスワードを入力する事で可能となります。

2.新規投稿
ドリンクのタイトルなど必要項目を記入する事で可能となります。
投稿したユーザーのみ詳細ページより編集・削除を行えます。

3.いいね・コメントをする
投稿詳細ページよりいいね・コメントを行う事が出来ます。
いいねした投稿はマイページより確認できます。

4.期間限定ページ
今だけのドリンクのカスタマイズ投稿を確認する事が出来ます。

## デモ画像

*投稿詳細ページ

![starbucks-labo3](https://user-images.githubusercontent.com/94495458/168611867-9d180999-b9a5-44fb-a681-96bbc53267f3.png)

*マイページ

![starbucks-labo4](https://user-images.githubusercontent.com/94495458/168612023-a7a89b49-8b92-4255-86fd-04d5464c1407.png)

## 使用技術

* Ruby 2.7.5
* Ruby on Rails 6.1.4
* MySQL 5.7
* Docker/Docker-compose
* Rspec
* Rubocop
* AWS
  * S3
* Heroku

## 機能一覧

* ユーザー登録、ログイン機能(devise)
* 投稿機能（画像:carrierwave)
* いいね機能
* コメント機能
* ページネーション機能(kaminari)
* 期間限定ページ機能

## テスト

* Rspec
  * 単体テスト(model)
  * 機能テスト(request)
  * 統合テスト(feature)
* Rubocop

## ゲストアカウント

*　ゲスト用ログインアカウント
  *　 メールアドレス: guest@gmail.com
  *　 パスワード: guestlogin

