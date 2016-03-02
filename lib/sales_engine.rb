require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'data_loader'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(hash)
    @items = populate_item_repository(hash[:items])
    @merchants = populate_merchant_repository(hash[:merchants])
  end

  def populate_item_repository(array)
    ItemRepository.new(array.map { |item| Item.new(item) })
  end

  def populate_merchant_repository(array)
    MerchantRepository.new(array.map { |merchant| Merchant.new(merchant) })
  end

  def self.from_csv(hash)
    data_array = hash.map { |key, path| DataLoader.from_CSV(path) }
    hash = convert_data_array_to_hash(data_array)
    SalesEngine.new(hash)
  end

  def self.convert_data_array_to_hash(data_array)
    [[:items, data_array[0]], [:merchants, data_array[1]]].to_h
  end
end

se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
  })


ir = se.items
item = ir.find_by_name("510+ RealPush Icon Set")
puts se
