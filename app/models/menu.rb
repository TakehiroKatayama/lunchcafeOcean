class Menu < ApplicationRecord
  mount_uploader :menu_image, MenuImageUploader

  validates :name, presence: true, length: { maximum: 20 }
  validates :content, length: { maximum: 100 }
  validates :menu_category, presence: true
  validates :menu_image, presence: true

  enum menu_category: {
    lunch: 0,
    cake: 1,
    wholecake: 2,
    others: 3
  }
end
