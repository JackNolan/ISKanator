module CharacterBlueprintsHelper
  def profitable?(character_blueprint)
    character_blueprint.produced_item.profit >= 0
  end
end
