# 実際に使っている飲食店予約管理サイト
<img width="1425" alt="Home画面" src="https://user-images.githubusercontent.com/80527303/152959878-d231594a-7a3f-412c-9ec4-af6f2f0f6821.png">

## URL
https://lunchcafeocean.herokuapp.com

## サービス概要
実際の飲食店で使っている予約サイト　兼　予約管理システム　(のクローンアプリ)

## 主な機能

### 一般ユーザー
- User 登録・ログイン機能
- 予約機能
- お問い合わせ機能

### 管理ユーザー
- 予約管理機能
  - 上限管理
  - キャンセル 
- お知らせ、メニュー投稿機能

## ユーザーが抱える課題
- 個人経営の小さな店のため事前の予約を推奨しているが電話のみのため予約に手間がかかっている。
- 24時間365日電話で予約受入れてるためプライベートと隔たりが少ない。
- 従業員間で予約管理ができず、予約数を把握できずにいる。
- 従業員数により予約可能数が変わるため柔軟に対応できるようにしたい。

⇨予約サイトと予約を簡単に管理できるシステムが欲しい

## 使用技術
### バックエンド
- Ruby 2.7.3
- Rails 6.0.3.7
- Rubocop
- RSpec

### フロントエンド
- HTML
- CSS(SCSS)
- JavaScript(jQuery)
- bootstrap4

## 主な Gem

- gem 'sorcery'
- gem 'enum_help'
- gem 'rails-i18n'
- gem 'simple_calendar'
- gem 'carrierwave'
- gem 'ransack'
- gem 'pagy'
- gem 'meta-tags'
- gem 'slack-notifier'

## ER図
<img width="414" alt="ER図" src="https://user-images.githubusercontent.com/80527303/152961835-27f56788-1886-48d6-a1ad-ba44cdd58ce0.png">

