class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.integer :customer_id, null:false
      t.integer :type_id, null:false
      t.integer :soup_id, null:false
      t.string :name, null: false
      t.string :address, null: false
      t.string :menu, null: false
      t.text :introduction, null: false
      t.float :rate, null: false
      t.boolean :status, default: false,null: false
      t.timestamps
    end
  end
end
