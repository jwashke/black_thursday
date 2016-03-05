require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'invoice'
require_relative 'data_loader'

class SalesEngine
  attr_reader :item_repository,
              :merchant_repository,
              :invoice_repository

  def initialize(hash)
    @item_repository     = populate_item_repository(hash[:items])
    @merchant_repository = populate_merchant_repository(hash[:merchants])
    @invoice_repository  = populate_invoice_repository(hash[:invoices])
    establish_relationships
  end

  def self.from_csv(hash)
    data_array = hash.map { |key, path| DataLoader.from_CSV(path) }
    hash = convert_data_array_to_hash(data_array)
    SalesEngine.new(hash)
  end

  def self.convert_data_array_to_hash(data_array)
    [[:items, data_array[0]], [:merchants, data_array[1]], [:invoices, data_array[3]]].to_h
  end

  def populate_item_repository(array)
    ItemRepository.new(array.map { |item| Item.new(item) })
  end

  def populate_merchant_repository(array)
    MerchantRepository.new(array.map { |merchant| Merchant.new(merchant) })
  end

  def populate_invoice_repository(array)
    InvoiceRepository.new(array.map { |invoice| Invoice.new(invoice) })
  end

  def establish_relationships
    connect_items_to_merchant
    connect_merchant_to_item
    connect_invoices_to_merchants
    connect_merchants_to_invoices
  end

  def connect_items_to_merchant
    @merchant_repository.all.each do |merchant|
      merchant.items = @item_repository.find_all_by_merchant_id(merchant.id)
    end
  end

  def connect_merchant_to_item
    @item_repository.all.each do |item|
      item.merchant = @merchant_repository.find_by_id(item.merchant_id)
    end
  end

  def connect_invoices_to_merchants
    @merchant_repository.all.each do |merchant|
      merchant.invoices = @invoice_repository.find_all_by_merchant_id(merchant.id)
    end
  end

  def connect_merchants_to_invoices
    @invoice_repository.all.each do |invoice|
      invoice.merchant = @merchant_repository.find_by_id(invoice.merchant_id)
    end
  end

  def invoices
    @invoice_repository
  end

  def merchants
    @merchant_repository
  end

  def items
    @item_repository
  end
end

# se = SalesEngine.from_csv({
#     :items     => "./data/items.csv",
#     :merchants => "./data/merchants.csv"
#   })


# ir = se.items
# item = ir.find_by_name("510+ RealPush Icon Set")
# puts se
