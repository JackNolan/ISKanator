require "spec_helper"
require "csv"

describe Importers::ItemImporter do
  let(:importer) { Importers::ItemImporter }

  before :each do
    importer.stub(:item_csv_path).and_return("spec/fixtures/csv/item.csv")
  end

  describe ".import!" do
    let(:csv_file_path) { Rails.root.join("spec/fixtures/csv/item.csv") }
    let(:csv) { CSV.open(csv_file_path) }
    let(:number_of_rows) { csv.count - 1 }

    it "creates the correct number of items" do
      expect{ importer.import! }.to change{ Item.count }.by(number_of_rows)
    end
  end

  describe ".item_csv_path" do
    it "returns the correct path" do
      importer.unstub(:item_csv_path)
      expect(importer.item_csv_path).to eq "lib/csv/item.csv"
    end
  end

  describe ".item_csv" do
    let(:item_csv) { [["name", "m3", "eve_id"], ["arazu", "2000", "3"], ["brutix", "2000", "2"], ["ospray", "2000", "5"], ["raven", "2000", "1"]] }

    it "returns the correct csv" do
      expect(importer.item_csv).to eq item_csv
    end
  end

  describe ".item_hashes" do
    let(:item_hashes) { [{"name"=>"arazu", "m3"=>"2000", "eve_id"=>"3"    },
                         {"name"=>"brutix", "m3"=>"2000", "eve_id"=>"2"   },
                         {"name"=>"ospray", "m3"=>"2000", "eve_id"=>"5"   },
                         {"name"=>"raven", "m3"=>"2000", "eve_id"=>"1"    }]}


    it "returns the hashed version of csv" do
      expect(importer.item_hashes).to eq item_hashes
    end
  end
end
