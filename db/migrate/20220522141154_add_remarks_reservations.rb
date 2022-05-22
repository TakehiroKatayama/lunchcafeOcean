class AddRemarksReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :remarks, :text
  end
end
