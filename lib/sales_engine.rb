require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'item'
require_relative 'merchant'
require_relative 'invoice'
require_relative 'invoice_item'
require_relative 'transaction'
require_relative 'customer'
require_relative 'data_loader'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(hash)
    @items         = ItemRepository.new(hash[:items])
    @merchants     ||= populate_merchant_repository(hash[:merchants])
    @invoices      ||= populate_invoice_repository(hash[:invoices])
    @invoice_items ||= populate_invoice_item_repository(hash[:invoice_items])
    @transactions  ||= populate_transaction_repository(hash[:transactions])
    @customers     ||= populate_customer_repository(hash[:customers])
    establish_relationships
  end

  def self.from_csv(path_hash)
    data_hash = {}
    path_hash.each { |key, path| data_hash[key] = DataLoader.from_CSV(path) }
    SalesEngine.new(data_hash)
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

  def populate_invoice_item_repository(array)
    InvoiceItemRepository.new(array.map do |invoice_item|
      InvoiceItem.new(invoice_item)
    end)
  end

  def populate_transaction_repository(array)
    TransactionRepository.new(array.map do |transaction|
      Transaction.new(transaction)
    end)
  end

  def populate_customer_repository(array)
    CustomerRepository.new(array.map { |customer| Customer.new(customer) })
  end

  def establish_relationships
   establish_item_relationships
   establish_merchant_relationships
   establish_invoice_item_relationships
   establish_invoice_relationships
   establish_transaction_relationships
  end

  def establish_item_relationships
    items.all.each do |item|
      item.merchant = merchants.find_by_id(item.merchant_id)
    end
  end

  def establish_merchant_relationships
    merchants.all.each do |merchant|
      merchant.invoices = invoices.find_all_by_merchant_id(merchant.id)
      merchant.items = items.find_all_by_merchant_id(merchant.id).uniq
      connect_customers_to_merchants(merchant)
    end
  end

  def establish_invoice_item_relationships
    invoice_items.all.each do |invoice_item|
      invoice_item.items = items.find_by_id(invoice_item.item_id)
    end
  end

  def establish_invoice_relationships
    invoices.all.each do |invoice|
      invoice.merchant = merchants.find_by_id(invoice.merchant_id)
      invoice.invoice_items = invoice_items.find_all_by_invoice_id(invoice.id).uniq
      invoice.items = connect_items_to_invoice(invoice)
      invoice.transactions = transactions.find_all_by_invoice_id(invoice.id).uniq
      invoice.customer = customers.find_by_id(invoice.customer_id)
    end
  end

  def establish_transaction_relationships
    transactions.all.each do |transaction|
      transaction.invoice = invoices.find_by_id(transaction.invoice_id)
    end
  end

  def connect_items_to_invoice(invoice)
    invoice.invoice_items.map do |invoice_item|
      invoice_item.items
    end
  end

  def connect_customers_to_merchants(merchant)
    merchant.customers = merchant.invoices.map do |invoice|
      customers.find_by_id(invoice.customer_id)
    end.uniq
  end
end
