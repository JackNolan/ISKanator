require "spec_helper"

describe CsvImporter do
  let(:csv_file_name) { "test_file.csv" }
  let(:file_path)     { Rails.root.join("spec/fixtures/csv/#{csv_file_name}") }
  let(:importer)      { CsvImporter.new(file_path) }

  describe ".import!(const_name)" do
    it "loads the csv into the correct table" do
      Item.should_receive(:create).once
      importer.import! Item
    end
  end

  describe ".new(csv_file_path)" do
    it "loads the csv file" do
      expect(importer.file).to be_a File
    end

    it "opens the correct file" do
      expect(importer.file_name).to eq file_path
    end
  end

  describe ".csv" do
    let(:csv) { [["header_one", "header_two", "header_three"], ["value_one", "value_two", "value_three"]] }

    it "returns the correct csv" do
      expect(importer.csv).to eq csv
    end
  end

  describe ".hashed_csv" do
    let(:hashed_csv) { [{ header_one: 'value_one', header_two: 'value_two', header_three: 'value_three' }] }

    it "returns the hashed version of csv" do
      expect(importer.hashed_csv).to eq hashed_csv
    end

    it "accepts a block of transformations" do
      expect(importer.hashed_csv{ |hash| hash[:foo] = 1; hash }.first).to include foo: 1
    end

    it "removes items that a pass block returns nil" do
      expect(importer.hashed_csv{ |hash| nil }).to be_empty
    end
  end
end
