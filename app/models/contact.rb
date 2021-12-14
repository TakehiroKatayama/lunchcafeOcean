class Contact < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A\d{10,11}\z/.freeze

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 256 }
  validates :phonenumber, presence: true, format: { with: VALID_PHONE_REGEX }, length: { in: 10..11 }
  validates :message, presence: true, length: { maximum: 2000 }
  validates :category, presence: true
  validates :status, presence: true
end
