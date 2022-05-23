class AddReservationMediaReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :reservation_media, :integer, default: 0
  end
end
