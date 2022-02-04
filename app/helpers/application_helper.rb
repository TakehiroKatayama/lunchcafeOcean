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
        { href: image_url('icon.jpg') },
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
end
