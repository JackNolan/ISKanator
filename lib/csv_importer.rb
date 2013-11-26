require 'csv'

class CsvImporter
  attr_accessor :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def import!(dest_class)
    hashed_csv.each do |row|
      dest_class.create(row)
    end
  end

  def file
    @file ||= File.new(file_name)
  end

  def csv
    @csv ||= CSV.parse file
  end

  def hashed_csv
    headers = csv.shift
    csv.map do |row|
      headers.zip(row).each_with_object({}) do |(header, value), row_hash|
        row_hash[header] = value
      end
    end
  end
end
