class News < ApplicationRecord
  mount_uploader :news_image, NewsImageUploader

  enum category: {
    info: 0,
    event: 1,
    menu: 2,
    campaign: 3
  }

  def previous
    News.where('id < ?', id).order('id desc').first
  end

  def next
    News.where('id > ?', id).order('id asc').first
  end
end
