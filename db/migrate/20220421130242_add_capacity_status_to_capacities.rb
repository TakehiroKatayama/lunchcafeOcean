class AddCapacityStatusToCapacities < ActiveRecord::Migration[6.0]
  def change
    add_column :capacities, :capacity_status, :integer, default: 0
  end
end
