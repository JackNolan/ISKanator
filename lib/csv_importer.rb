require 'csv'

class CsvImporter
  attr_accessor :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def import!(dest_class)
    hashed_csv.each do |row|
      puts "Creating an #{dest_class.to_s} with params #{row}" unless Rails.env.test?
      dest_class.create(row)
    end
  end

  def file
    @file ||= File.new(file_name)
  end

  def csv
    @csv ||= CSV.parse file, :quote_char => "|"
  end

  def hashed_csv
    headers = csv.shift
    csv.map do |row|
      headers.zip(row).each_with_object({}) do |(header, value), row_hash|
        key   = header.encode('windows-1252', :replace => '').encode('UTF-8') # handle encoding issues between windows and mac
        value = value.encode('windows-1252', :replace => '').encode('UTF-8') # handle encoding issues between windows and mac
        row_hash[key.to_sym] = value
      end
    end
  end
end
