desc "Imports csv from the eve data dump"

task :import => :environment do
  # Importers::ItemImporter.import!
  Item.delete_all
  CsvImporter.new(Rails.root.join("lib/csv_files/item.csv")).import!(Item)

  # CsvImporter.new(Rails.root.join("lib/csv/blueprints.csv"))
  # CsvImporter.new(Rails.root.join("lib/csv/extra_materials.csv"))
  # CsvImporter.new(Rails.root.join("lib/csv/materials.csv"))
  # CsvImporter.new(Rails.root.join("lib/csv/skills.csv"))
end
