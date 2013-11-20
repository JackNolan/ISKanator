class CharacterBlueprint < ActiveRecord::Base
  belongs_to :character
  belongs_to :blueprint

  def bill_of_materials
    blueprint.materials.map do |material|
      mat = material.dup
      mat.amount = (material.amount + material.amount * skill_waste_percent + material.amount * blueprint_waste_percent).round(0)
      mat
    end
  end

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

  private
    def skill_waste_percent
      0.25 - character.production_efficiency_level * 0.05
    end

    def blueprint_waste_percent
      base = 10.0
      if material_efficiency >= 0
        (base / 100) * 1.0 / (material_efficiency + 1)
      else
        (base / 100) * (1 - material_efficiency)
      end
    end
end
