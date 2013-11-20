class CharacterBlueprint < ActiveRecord::Base
  belongs_to :character
  belongs_to :blueprint

  def blueprint_name
    blueprint.try(:name)
  end

  def build_cost
    0.0
  end

  def profit
    sell_price - build_cost
  end

  def profitable?(character_blueprint)
    character_blueprint.produced_item.profit >= 0
  end
end
