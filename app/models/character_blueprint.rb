class CharacterBlueprint < ActiveRecord::Base
  belongs_to :character
  belongs_to :blueprint

  def bill_of_materials
    @bill_of_materials ||= blueprint.materials.map do |material|
      mat = material.dup
      mat.amount = (material.amount + material.amount * skill_waste_percent + material.amount * blueprint_waste_percent).round(0) unless mat.extra?
      mat
    end
  end

  def compacted_bill_of_materials
    compacted = {}
    bill_of_materials.each do |material|
      if mat = compacted[material.item_name]
        mat.amount += material.amount
      else
        mat = material
      end
    end
    compacted.values
  end

  def extra_materials
    bill_of_materials.select{ |material| material.extra? }
  end

  def required_materials
    bill_of_materials.reject{ |material| material.extra? }
  end

  def blueprint_name
    blueprint.try(:name)
  end

  def blueprint_produced_item
    blueprint.try(:produced_item)
  end

  def build_cost
    0.0
  end

  def sell_price
    blueprint_produced_item.sell_price
  end

  def profit
    sell_price - build_cost
  end

  def profitable?
    profit >= 0
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
