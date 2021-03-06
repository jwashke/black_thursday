require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'data_loader'

class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(hash)
    @items         ||= ItemRepository.new(hash[:items])
    @merchants     ||= MerchantRepository.new(hash[:merchants])
    @invoices      ||= InvoiceRepository.new(hash[:invoices])
    @invoice_items ||= InvoiceItemRepository.new(hash[:invoice_items])
    @transactions  ||= TransactionRepository.new(hash[:transactions])
    @customers     ||= CustomerRepository.new(hash[:customers])
    establish_relationships
  end

  def self.from_csv(path_hash)
    data_hash = {}
    path_hash.each { |key, path| data_hash[key] = DataLoader.from_CSV(path) }
    SalesEngine.new(data_hash)
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
      merchant.invoices  = invoices.find_all_by_merchant_id(merchant.id)
      merchant.items     = items.find_all_by_merchant_id(merchant.id).uniq
      merchant.customers = connect_customers_to_merchant(merchant)
    end
  end

  def establish_invoice_item_relationships
    invoice_items.all.each do |invoice_item|
      invoice_item.items = items.find_by_id(invoice_item.item_id)
    end
  end

  def establish_invoice_relationships
    invoices.all.each do |invoice|
      invoice.merchant      = merchants.find_by_id(invoice.merchant_id)
      invoice.invoice_items = connect_invoice_items_to_invoice(invoice)
      invoice.items         = connect_items_to_invoice(invoice)
      invoice.transactions  = connect_transactions_to_invoice(invoice)
      invoice.customer      = customers.find_by_id(invoice.customer_id)
    end
  end

  def connect_invoice_items_to_invoice(invoice)
    invoice_items.find_all_by_invoice_id(invoice.id).uniq
  end

  def connect_transactions_to_invoice(invoice)
    transactions.find_all_by_invoice_id(invoice.id).uniq
  end

  def connect_items_to_invoice(invoice)
    invoice.invoice_items.map do |invoice_item|
      invoice_item.items
    end
  end

  def establish_transaction_relationships
    transactions.all.each do |transaction|
      transaction.invoice = invoices.find_by_id(transaction.invoice_id)
    end
  end

  def connect_customers_to_merchant(merchant)
    merchant.invoices.map do |invoice|
      customers.find_by_id(invoice.customer_id)
    end.uniq
  end
end
