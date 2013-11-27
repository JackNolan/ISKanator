class CreateBlueprints < ActiveRecord::Migration
  def change
    create_table :blueprints do |t|
      t.string  :name
      t.integer :eve_id
      t.integer :manufacturing_time
      t.integer :research_manufactoring_efficiency_time
      t.integer :research_production_time
      t.integer :produced_item_id
      t.integer :price_cents
      t.integer :invention_time
      t.integer :base_waste
      t.integer :max_copies
      t.integer :copy_time

      t.timestamps
    end
  end
end
