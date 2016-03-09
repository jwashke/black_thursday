require_relative 'test_helper'
require 'minitest/autorun'
require "minitest/pride"
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

class ItemAnalysisTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
      :items         => "./test/test_data/items.csv",
      :merchants     => "./test/test_data/merchants.csv",
      :customer      => "./test/test_data/merchants.csv",
      :invoices      => "./test/test_data/invoices.csv",
      :invoice_items => "./test/test_data/invoice_items.csv",
      :transactions  => "./test/test_data/transactions.csv",
      :customers     => "./test/test_data/customers.csv" })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_returns_golden_items
    assert_equal 1, @sa.golden_items.count
    assert_equal Item, @sa.golden_items.first.class
  end

  def test_it_returns_the_item_price_standard_deviation
    assert_equal 8901.79, @sa.item_price_standard_deviation
  end
end
