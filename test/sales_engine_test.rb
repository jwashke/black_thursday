require_relative 'test_helper'
require 'minitest/autorun'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @test_helper = TestHelper.new
    @se = SalesEngine.from_csv({
      :items         => "./test/test_data/items.csv",
      :merchants     => "./test/test_data/merchants.csv",
      :customer      => "./test/test_data/merchants.csv",
      :invoices      => "./test/test_data/invoices.csv",
      :invoice_items => "./test/test_data/invoice_items.csv",
      :transactions  => "./test/test_data/transactions.csv",
      :customers     => "./test/test_data/customers.csv" })
  end

  def test_it_can_be_instantiated
    assert @se.instance_of?(SalesEngine)
  end

  def test_it_has_a_item_repository
    assert @se.items.instance_of?(ItemRepository)
  end

  def test_it_populates_item_repository_with_an_item_object
    assert @se.items.all[0].instance_of?(Item)
  end

  def test_its_item_repository_loaded_all_items
    assert_equal 126, @se.items.all.count
  end

  def test_its_item_instances_are_connected_to_a_merchant
    assert @se.items.all[0].merchant.instance_of?(Merchant)
  end

  def test_it_has_a_merchant_repository
    assert @se.merchants.instance_of?(MerchantRepository)
  end

  def test_it_populated_merchant_repository_with_merchant_object
    assert @se.merchants.all[0].instance_of?(Merchant)
  end

  def test_its_merchant_repository_loaded_all_merchants
    assert_equal 108, @se.merchants.all.count
  end

  def test_its_merchant_instances_are_connected_to_invoices
    assert_equal 1, @se.merchants.all[0].invoices.count
  end

  def test_its_merchant_instances_are_connected_to_items
    assert_equal 1, @se.merchants.all[0].items.count
  end

  def test_its_merchant_instances_are_connected_to_customers
    assert_equal 1, @se.merchants.all[0].customers.count
  end

  def test_it_has_a_invoices_repository
    assert @se.invoices.instance_of?(InvoiceRepository)
  end

  def test_it_populated_invoice_repository_with_invoice_object
    assert @se.invoices.all[0].instance_of?(Invoice)
  end

  def test_its_invoice_repository_loaded_all_invoices
    assert_equal 100, @se.invoices.all.count
  end

  def test_its_invoices_instances_are_connected_to_a_merchant
    assert @se.invoices.all[42].merchant.instance_of?(Merchant)
  end

  def test_its_invoice_instances_are_connected_to_invoice_items
    assert_equal 8, @se.invoices.all[0].invoice_items.count
  end

  def test_its_invoice_instances_are_connected_to_items
    assert_equal 8, @se.invoices.all[0].items.count
  end

  def test_its_invoice_instances_are_connected_to_transactions
    assert_equal 1, @se.invoices.all[25].transactions.count
  end

  def test_its_invoice_instances_are_connected_to_a_customer
     assert @se.invoices.all[1].customer.instance_of?(Customer)
  end

  def test_it_has_a_invoice_item_repository
    assert @se.invoice_items.instance_of?(InvoiceItemRepository)
  end

  def test_it_populated_invoice_item_repository_with_invoice_item_object
    assert @se.invoice_items.all[0].instance_of?(InvoiceItem)
  end

  def test_its_invoice_item_repository_loaded_all_invoice_items
    assert_equal 100, @se.invoice_items.all.count
  end

  def test_its_invoice_item_instances_are_connected_to_items
    assert @se.invoice_items.all[0].items.instance_of?(Item)
  end

  def test_it_has_a_transactions_repository
    assert @se.transactions.instance_of?(TransactionRepository)
  end

  def test_it_populated_transaction_repository_with_transactions_objects
    assert @se.transactions.all[0].instance_of?(Transaction)
  end

  def test_its_transaction_repository_loaded_all_transactions
    assert_equal 148, @se.transactions.all.count
  end

  def test_its_transactions_instances_are_connected_to_an_invoice
    assert @se.transactions.all[1].invoice.instance_of?(Invoice)
  end

  def test_it_has_a_customer_repository
    assert @se.customers.instance_of?(CustomerRepository)
  end

  def test_it_populated_customer_repository_with_customer_objects
    assert @se.customers.all[0].instance_of?(Customer)
  end

  def test_its_customer_repository_loaded_all_customers
    assert_equal 99, @se.customers.all.count
  end
end
