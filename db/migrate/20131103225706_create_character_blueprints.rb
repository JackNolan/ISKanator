class CreateCharacterBlueprints < ActiveRecord::Migration
  def change
    create_table :character_blueprints do |t|
      t.integer :blueprint_id
      t.integer :character_id
      t.integer :material_level
      t.integer :production_efficiency

      t.timestamps
    end
  end
end
