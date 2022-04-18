module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'ランチカフェオーシャン'
    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def default_meta_tags
    {
      site: 'ランチカフェオーシャン',
      title: '海の見えるランチカフェ予約サイト',
      reverse: true,
      charset: 'utf-8',
      description: 'description',
      keywords: 'ランチ,カフェ,スイーツ,ケーキ,予約,海,絶景,海が見える,眺めの良い',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('icon.jpg'),
        locale: 'ja_JP'
      }
    }
  end

  # Newsのカテゴリーの値によって出力される名前を変える
  def news_category
    case params[:category]
    when 'event'
      'イベント'
    when 'menu'
      'メニュー'
    when 'campaign'
      'キャンペーン'
    else
      'お知らせ'
    end
  end

  # 予約時登録slackへ通知を送る
  def reservation_to_slack
    notifier = Slack::Notifier.new(
      Rails.application.credentials.slack[:notifier],
      channel: '#予約通知',
      username: '予約通知くん'
    )
    notifier.ping('新しい予約がありました！')
  end

  # お問い合わせ登録時slackへ通知を送る
  def contact_to_slack
    notifier = Slack::Notifier.new(
      Rails.application.credentials.slack[:notifier],
      channel: '#お問い合わせ通知',
      username: 'お問い合わせ通知くん'
    )
    notifier.ping('新しいお問い合わせがありました！')
  end
end
