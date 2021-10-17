class User < ApplicationRecord
  authenticates_with_sorcery!

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)\w{8,36}\z/.freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A\d{10,11}\z/.freeze

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX, message: 'は正しいメールアドレスを入力してください' }, length: { maximum: 256 }
  validates :phonenumber, presence: true, uniqueness: true, format: { with: VALID_PHONE_REGEX, message: 'は正しい電話番号を入力してください' }, length: { in: 10..11 }
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英字・数字を混ぜて8文字以上36文字以内にしてください' }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
end
