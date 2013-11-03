class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.float :m3
      t.integer :price_cents
      t.integer :eve_id

      t.timestamps
    end
  end
end
