class CreateCapacities < ActiveRecord::Migration[6.0]
  def change
    create_table :capacities do |t|
      t.date :start_time, null: false
      t.integer :remaining_seat, default: 20, null: false

      t.timestamps
    end
  end
end
