class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :capacity

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PHONE_REGEX = /\A\d{10,11}\z/

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX, message: 'は正しいメールアドレスを入力してください' }, length: { maximum: 256 }
  validates :phonenumber, presence: true, format: { with: VALID_PHONE_REGEX, message: 'は正しい電話番号を入力してください' }, length: { in: 10..11 }
  validates :number_of_people, presence: true
  validates :visiting_time, presence: true
  validates :reservations_status, presence: true
  validates :capacity_id, presence: true

  validate :date_before_today
  validate :start_time_not_sunday
  validate :start_time_not_monday

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

  def date_before_today
    errors.add(:start_time, 'は過去の日付は選択できません') if capacity.start_time < Time.zone.today
  end

  def start_time_not_sunday
    errors.add(:start_time, 'は定休日(月曜日・日曜日)以外を選択してください') if capacity.start_time.sunday?
  end

  def start_time_not_monday
    errors.add(:start_time, 'は定休日(月曜日・日曜日)以外を選択してください') if capacity.start_time.monday?
  end
end
