class News < ApplicationRecord
  mount_uploader :news_image, NewsImageUploader

  has_rich_text :body

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

  # newsのカテゴリー毎に一覧に表示するnewsを分ける
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

  # newsの一つ前のidを取得する
  def previous
    News.where('id < ?', id).order('id desc').first
  end

  # newsの一つ後のidを取得する
  def next
    News.where('id > ?', id).order('id asc').first
  end

  PER_NEWS_PAGE = 6

  # 最新6件のnewsを降順で取得する
  scope :latest, -> { order(created_at: 'desc').first(PER_NEWS_PAGE) }
end
