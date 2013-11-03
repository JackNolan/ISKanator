class CharacterBlueprint < ActiveRecord::Base
  belongs_to :character
  belongs_to :blueprint
end
