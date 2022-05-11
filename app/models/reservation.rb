class Reservation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :capacity

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A\d{10,11}\z/.freeze

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX, message: 'は正しいメールアドレスを入力してください' }, length: { maximum: 256 }
  validates :phonenumber, presence: true, format: { with: VALID_PHONE_REGEX, message: 'は正しい電話番号を入力してください' }, length: { in: 10..11 }
  validates :number_of_people, presence: true
  validates :visiting_time, presence: true
  validates :reservation_status, presence: true
  validates :capacity_id, presence: true

  validate :date_before_today, on: :create # 新規予約登録時のみバリデーションを適用する
  validate :not_reservation_capacity_status

  enum visiting_time: {
    '11:00': 0,
    '11:30': 1,
    '12:00': 2,
    '12:30': 3,
    '13:00': 4,
    '13:30': 5,
    '14:00': 6
  }

  enum reservation_status: {
    visiting: 0,
    visited: 1,
    cancel: 2
  }

  # 予約日が今日以前の日付を制限するバリデーション
  def date_before_today
    errors.add(:start_time, 'は過去の日付は選択できません') if capacity.start_time < Time.zone.today
  end

  # capacityのステータスによってバリデーションを発生させる。
  def not_reservation_capacity_status
    case capacity.capacity_status
    when 'closed'
      errors.add(:start_time, 'は休業日です。')
    when 'full'
      errors.add(:start_time, 'は予約ができませんでした。一度店舗までご連絡下さい。')
    end
  end

  # 席数から予約人数をマイナスする
  def decreased_capacity
    capacity.remaining_seat - number_of_people
  end

  # 席数に変更人数をプラスする
  def increased_capacity
    capacity.remaining_seat + number_of_people
  end

  # 予約人数分、席数を変更する
  def change_capacity
    capacity.update!(remaining_seat: decreased_capacity)
  end

  # 席数を予約人数分戻す
  def return_capacity
    capacity.update!(remaining_seat: increased_capacity)
  end

  # 予約ステータスをキャンセル済みに変更する
  def status_cancel
    update!(reservation_status: 'cancel')
  end

  # 席数が０になった際にステータスを満席に更新する
  def full?
    capacity.update!(capacity_status: 'full') if capacity.remaining_seat.zero?
  end

  # 席数が０以外になった際にステータスを空席に更新する
  def vacancy?
    capacity.update!(capacity_status: 'vacancy') if capacity.remaining_seat != 0
  end

  # 予約ステータスを来店済みに更新
  scope :status_visitesd, -> { update(reservation_status: 'visited') }

  # 予約ステータスが来店済みに更新
  scope :today_reservation, -> { where(reservation_status: 'visiting', capacity_id: Capacity.today_id) }

  # 作成から一週間以内のものを降順にで取得するscopeを呼び出す
  include Recent
end
