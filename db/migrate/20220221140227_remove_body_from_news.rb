class RemoveBodyFromNews < ActiveRecord::Migration[6.0]
  def change
    remove_column :news, :body, :text
  end
end
