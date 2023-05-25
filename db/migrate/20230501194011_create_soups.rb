class CreateSoups < ActiveRecord::Migration[6.1]
  def change
    create_table :soups do |t|

      t.string :name, null: false
      t.timestamps
    end
  end
end
