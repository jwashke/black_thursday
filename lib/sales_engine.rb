require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'data_loader'
require 'pry'
class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(hash)
    @items = item_method_name_needed(hash[:items])
    @merchants = merchant_method_name_needed(hash[:merchants])
  end

  def item_method_name_needed(array)
    ItemRepository.new(array.map { |item| Item.new(item) })
  end

  def merchant_method_name_needed(array)
    MerchantRepository.new(array.map { |merchant| Merchant.new(merchant)})
  end

  def self.from_csv(hash)
    data_array = hash.each do |key, path|
      hash[key] = DataLoader.from_CSV(path)
    end
    SalesEngine.new(hash)
  end
end

se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"
  })


ir = se.items
item = ir.find_by_name("510+ RealPush Icon Set")
puts se.merchants
