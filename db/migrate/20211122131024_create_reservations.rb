class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phonenumber, null: false
      t.integer :number_of_people, null: false
      t.integer :visiting_time, null: false
      t.integer :reservation_status, default: 0, null: false
      t.references :user, foreign_key: true
      t.references :capacity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
