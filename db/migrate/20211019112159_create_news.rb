class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.integer :category, null: false
      t.string :news_image

      t.timestamps
    end
  end
end
