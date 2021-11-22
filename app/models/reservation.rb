class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :capacity

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
end
