class News < ApplicationRecord
  mount_uploader :news_image, NewsImageUploader

  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 5000 }
  validates :category, presence: true

  enum category: {
    info: 0,
    event: 1,
    menu: 2,
    campaign: 3
  }

  ALL_CATEGORY = %w[info event menu campaign].freeze

  def self.category_list(category)
    case category
    when 'info'
      where(category: 0)
    when 'event'
      where(category: 1)
    when 'menu'
      where(category: 2)
    when 'campaign'
      where(category: 3)
    else
      where(category: News::ALL_CATEGORY)
    end
  end

  def previous
    News.where('id < ?', id).order('id desc').first
  end

  def next
    News.where('id > ?', id).order('id asc').first
  end

  scope :latest, -> { order(created_at: 'desc').first(6) }
end
