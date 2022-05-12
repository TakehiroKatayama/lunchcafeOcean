class Capacity < ApplicationRecord
  has_many :reservations

  validates :remaining_seat, numericality: { greater_than_or_equal_to: 0 }

  enum capacity_status: {
    vacancy: 0,
    full: 1,
    closed: 2
  }

  # キャパ変更時に０だと満席に、0以外で満席の際は空席にステータス更新する。
  def full?
    if remaining_seat.zero?
      update!(capacity_status: 'full')
    elsif remaining_seat != 0 && capacity_status == 'full'
      update!(capacity_status: 'vacancy')
    end
  end

  # 予約テーブルに紐づく今日の日付のIDを呼び出す
  scope :today_id, -> { find_by(start_time: Time.zone.today).id }
end
