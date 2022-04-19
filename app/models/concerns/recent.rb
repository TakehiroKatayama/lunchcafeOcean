module Recent
  extend ActiveSupport::Concern

  # 作成から一週間以内のものを降順にで取得する
  included do
    scope :one_week, -> { where(created_at: 1.week.ago..Time.zone.now).order(created_at: 'desc') }
  end
end
