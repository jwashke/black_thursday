require 'CSV'

class DataLoader
  def self.from_CSV(filename)
    contents = CSV.open(filename, headers: true, header_converters: :symbol)
    parse_data_to_hash(contents)
  end

  def self.parse_data_to_hash(contents)
    contents.map { |row| row.to_h }
  end
end
