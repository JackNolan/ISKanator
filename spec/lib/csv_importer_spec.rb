require "spec_helper"

describe CsvImporter do
  let(:csv_file_name) { "test_file.csv" }
  let(:file_path)     { Rails.root.join("spec/cassettes/csv/#{csv_file_name}") }
  let(:importer)      { CsvImporter.new(file_path) }

  describe ".import!" do
    it "" do

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
    let(:csv) { "header_one,header_two,header_three\nvalue_one,value_two,value_three\n" }
    it "returns the correct csv" do
      expect(importer.csv).to eq csv
    end
  end
end
