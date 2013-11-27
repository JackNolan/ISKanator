desc "Imports csv from the eve data dump"

task :import => :environment do
  Item.delete_all
  Blueprint.delete_all
  Skill.delete_all
  Material.delete_all

  CsvImporter.new(Rails.root.join("lib/csv_files/item.csv")).import!(Item)

  CsvImporter.new(Rails.root.join("lib/csv_files/skills.csv")).import!(Skill)

  CsvImporter.new(Rails.root.join("lib/csv_files/blueprints.csv")).import! Blueprint do |hash|
    product_eve_id = hash.delete(:product_type_id)
    hash[:produced_item_id] = Item.where(eve_id: product_eve_id).pluck(:id).first
    if hash[:produced_item_id]
      hash
    else
      puts "Unable to add blueprint #{hash[:name]}"
      nil
    end
  end

  CsvImporter.new(Rails.root.join("lib/csv_files/materials.csv")).import! Material do |hash|
    item_eve_id = hash.delete(:item_type_id)
    blueprint_eve_id = hash.delete(:blueprint_type_id)
    hash[:extra] = false
    hash[:activity_type] = "Manufacturing"
    hash[:blueprint_id] = Blueprint.where(eve_id: blueprint_eve_id).pluck(:id).first
    hash[:item_id] = Item.where(eve_id: item_eve_id).pluck(:id).first

    if hash[:blueprint_id] && hash[:item_id]
      hash
    else
      puts "Unable to add Material between  blueprint: #{hash[:blueprint_id]}, item: #{hash[:item_id]}"
      nil
    end
  end

  CsvImporter.new(Rails.root.join("lib/csv_files/extra_materials.csv")).import! Material do |hash|
    item_eve_id = hash.delete(:item_type_id)
    blueprint_eve_id = hash.delete(:blueprint_type_id)
    hash[:extra] = true
    hash[:activity_type] = "Manufacturing"
    hash[:blueprint_id] = Blueprint.where(eve_id: blueprint_eve_id).pluck(:id).first
    hash[:item_id] = Item.where(eve_id: item_eve_id).pluck(:id).first

    if hash[:blueprint_id] && hash[:item_id]
      hash
    else
      puts "Unable to add extra Materials between  blueprint: #{hash[:blueprint_id]}, item: #{hash[:item_id]}"
      nil
    end
  end

end
