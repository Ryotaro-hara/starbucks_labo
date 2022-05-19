# Starbucks　Labo

#### URL https://floating-chamber-79672.herokuapp.com/

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

![starbucks-labo2](https://user-images.githubusercontent.com/94495458/169180923-b393ba68-facf-451d-a1c6-515c6fd12364.png)

*マイページ

![starbucks-labo3](https://user-images.githubusercontent.com/94495458/169180954-6f2f3962-8c25-4b7d-ab0f-52c8e7d3af56.png)

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
* 検索機能(ransack)
* Twitterシェア機能

## テスト

* Rspec
  * 単体テスト(model)
  * 機能テスト(request)
  * 統合テスト(feature)
* Rubocop

## ER図

![ER図](https://user-images.githubusercontent.com/94495458/168694306-87387c58-15c6-4e65-bc33-8321d3f6f171.png)

## ゲストアカウント

* ゲスト用ログインアカウント
  * メールアドレス: guest@gmail.com
  * パスワード: guestlogin

