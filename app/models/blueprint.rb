class Blueprint < ActiveRecord::Base
  belongs_to :produced_item, foreign_key: "produced_item_id", class_name: "Item"

  has_many :materials
  has_many :items, through: :materials

  has_many :character_blueprints
  has_many :characters, through: :character_blueprints

  def require_materials
    materials.where(extra: false)
  end

  def extra_materials
    materials.where(extra: true)
  end

  def produced_item_name
    produced_item.try(:name)
  end
end
