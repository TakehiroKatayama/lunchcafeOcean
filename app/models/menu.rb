class Menu < ApplicationRecord
  mount_uploader :menu_image, MenuImageUploader

  enum category: {
    lunch: 0,
    cake: 1,
    wholecake: 2,
    others: 3
  }
end
