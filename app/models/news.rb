class News < ApplicationRecord
  enum category: {
    info: 0,
    event: 1,
    menu: 2,
    campaign: 3
  }
end
