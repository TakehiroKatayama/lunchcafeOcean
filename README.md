# lunchcafeOcean

## サービス概要

実際に運用している小さな個人経営のランチカフェの予約システム
（実際に運用しているアプリには個人情報が含まれるためそのクローンアプリとなっております)

## サービスを作成する理由

私は以前、実際に運用しているカフェを手伝いながら、オンラインでマーケティングの学習をしておりました。
マーケティングの施策に携わらせて頂き、イベント出展や SNS 運用など実施してきましたが、来店に繋げるためには HP の重要性を実感しました。
名前は分かったが、ランチに限定数があるなら来店しづらい、場所が分かりづらい、メニューなどが分からないなど。
特に、予約を推奨しているが電話予約しかできないのが来店に繋がりにくいボトルネックだと考えた。
そこで簡単に予約できるシステムがあれば集客に繋がると考え作成。
コロナ禍で苦しむ飲食店を助けたいという思いから作成しました。

## ターゲットユーザー

- 飲食店の新規・既存の顧客
- 飲食店従業員

## ユーザー課題

- コロナ禍で新規の顧客を獲得できない
- フードロスをなくすために事前予約をして欲しい

## 解決方法

## 実装予定の機能

- 顧客が簡単に来店予約を行えるシステムを作成
- 従業員が簡単に予約を管理できるシステムを作成

- User 登録・ログイン
- 予約(ユーザーログインなしでも使用可能、ログイン場合は個人情報入力の手間を削減)
- お知らせ投稿表示
- お問い合わせ
- 予約・お問い合わせ時入力アドレスにメールを送信
- Googlemap
- 予約・お問い合わせ時、管理者 Slack 通知
- 管理者機能
  - 予約確認
  - 予約投稿(電話や SNS 予約を同時管理)
  - 予約変更
  - 予約キャンセル
  - 上限人数変更機能
  - お知らせ投稿
  - メニュー投稿
  - お問い合わせ確認

## 主な Gem

- gem 'sorcery'
- gem 'enum_help'
- gem 'rails-i18n'
- gem 'simple_calendar'
- gem 'dotenv-rails'
- gem 'carrierwave'
- gem 'ransack'
- gem 'kaminari'
- gem 'meta-tags'
- gem 'slack-notifier'
- gem 'pry-byebug'
- gem 'better_errors'
- gem 'binding_of_caller'
- gem 'letter_opener_web'
- gem 'bullet'
- gem ‘rubocop’, require: false
- gem ‘rubocop-rails’, require: false’
- gem 'rspec-rails'
- gem 'factory_bot_rails'
- gem 'capybara'
- gem 'webdrivers'
