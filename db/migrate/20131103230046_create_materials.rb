class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.integer :blueprint_id
      t.integer :item_id
      t.integer :amount
      t.integer :percent_consumed
      t.string  :activity_type

      t.timestamps
    end
  end
end
