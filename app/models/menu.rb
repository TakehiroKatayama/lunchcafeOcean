class Menu < ApplicationRecord
  enum category: {
    lunch: 0,
    cake: 1,
    wholecake: 2,
    others: 3
  }
end
