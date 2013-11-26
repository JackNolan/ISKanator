require 'csv'

class Importers::ItemImporter
  class << self
    def import!
      item_hashes.each do |item_hash|
        Item.create item_hash
      end
    end

    def item_csv
      CSV.open(item_csv_path).to_a
    end

    def item_csv_path
      "lib/csv/item.csv"
    end

    def item_hashes
      csv = item_csv
      headers = csv.shift

      csv.map do |row|
        headers.zip(row).each_with_object({}) do |(header, value), row_hash|
          row_hash[header] = value
        end
      end
    end

  end
end
