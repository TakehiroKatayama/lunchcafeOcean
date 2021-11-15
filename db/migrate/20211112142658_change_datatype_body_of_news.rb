class ChangeDatatypeBodyOfNews < ActiveRecord::Migration[6.0]
  def change
    change_column :news, :body, :text
  end
end
