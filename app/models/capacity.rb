class Capacity < ApplicationRecord
  has_many :reservations

  validates :remaining_seat, numericality: { greater_than_or_equal_to: 0 }

  enum capacity_status: {
    vacancy: 0,
    full: 1,
    closed: 2
  }
end
