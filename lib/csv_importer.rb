class CsvImporter
  attr_accessor :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def file
    @file ||= File.new(file_name)
  end

  def csv
    file.read
  end
end
