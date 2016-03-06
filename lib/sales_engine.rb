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
require 'pry'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(hash)
    @items         ||= populate_item_repository(hash[:items])
    @merchants     ||= populate_merchant_repository(hash[:merchants])
    @invoices      ||= populate_invoice_repository(hash[:invoices])
    @invoice_items ||= populate_invoice_item_repository(hash[:invoice_items])
    @transactions  ||= populate_transaction_repository(hash[:transactions])
    @customers     ||= populate_customers_repository(hash[:customers])
    establish_relationships
  end

  def self.from_csv(hash)
    data_array = hash.map { |key, path| DataLoader.from_CSV(path) }
    hash = convert_data_array_to_hash(data_array)
    SalesEngine.new(hash)
  end

  def self.convert_data_array_to_hash(data_array)
    binding.pry
    [[:items, data_array[0]],
     [:merchants, data_array[1]],
     [:invoices, data_array[3]],
     [:invoice_items, data_array[4]],
     [:transactions, data_array[5]],
     [:customers, data_array[2]]].to_h
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
    InvoiceItemRepository.new(array.map { |invoice_item| InvoiceItem.new(invoice_item) })
  end

  def populate_transaction_repository(array)
    TransactionRepository.new(array.map { |transaction| Transaction.new(transaction) })
  end

  def populate_customer_repository(array)
    CustomerRepository.new(array.map { |customer| Customer.new(customer) })
  end

  def establish_relationships
    connect_merchant_to_item
    connect_invoices_and_items_to_merchants
    connect_merchants_to_invoices
    connect_items_transactions_and_customers_to_invoice
    connect_invoice_to_transaction
  end

  def connect_merchant_to_item
    items.all.each do |item|
      item.merchant = merchants.find_by_id(item.merchant_id)
    end
  end

  def connect_invoices_and_items_to_merchants
    merchants.all.each do |merchant|
      merchant.invoices = invoices.find_all_by_merchant_id(merchant.id)
      merchant.items = items.find_all_by_merchant_id(merchant.id)
    end
  end

  def connect_merchants_to_invoices
    invoices.all.each do |invoice|
      invoice.merchant = merchants.find_by_id(invoice.merchant_id)
    end
  end

  def connect_invoice_to_transaction
    transactions.all.each do |transaction|
      transaction.invoice = invoices.find_by_id(transaction.invoice_id)
    end
  end

  def connect_items_transactions_and_customers_to_invoice
    invoices.all.each do |invoice|
      invoice.merchant = merchants.find_by_id(invoice.merchant_id)
      invoice_items_array = invoice_items.find_all_by_invoice_id(invoice.id)
      invoice.items = invoice_items_array.map { |invoice_item| items.find_by_id(invoice_item.item_id) }
      invoice.transactions = transactions.find_all_by_invoice_id(invoice.id)
      #invoice.customers = customers.find_by_id(invoice.customer_id)
    end
  end
end
