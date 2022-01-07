class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
      t.string :name, null: false
      t.string :content
      t.integer :menu_category, null: false
      t.string :menu_image

      t.timestamps
    end
  end
end
