class CharacterBlueprint < ActiveRecord::Base
  belongs_to :character
  belongs_to :blueprint

  def blueprint_name
    blueprint.try(:name)
  end

  def produced_item
    blueprint.try(:produced_item)
  end
end
