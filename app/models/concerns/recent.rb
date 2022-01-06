module Recent
  extend ActiveSupport::Concern

  included do
    scope :one_week, -> { where(created_at: 1.week.ago..Time.zone.today).order(created_at: 'desc') }
    # 作成から一週間以内のものを降順にで取得する
  end
end
