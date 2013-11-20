class CharacterBlueprint < ActiveRecord::Base
  belongs_to :character
  belongs_to :blueprint

  def bill_of_materials
    blueprint.materials.each do |material|
      material.ammount = (material.ammount * charater_pe_discount * blueprint_me_waste).to_i
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
    def charater_pe_discount
      (1 - character.production_efficiency_level * 0.05)
    end

    def blueprint_me_waste
      base = 10.0

      if material_efficiency >= 0
        1 + (base / 100) * 1.0 / (material_efficiency + 1)
      else
        1 + (base / 100) * (1 - material_efficiency)
      end
    end
end
