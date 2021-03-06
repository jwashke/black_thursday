require_relative 'test_helper'
require 'minitest/autorun'
require "minitest/pride"
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'


class SalesAnalystTest < Minitest::Test
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

  def test_it_can_be_instantiated
    assert @sa.instance_of?(SalesAnalyst)
  end

  def test_it_can_find_the_average
    assert_equal 3.03, @sa.average(100, 33)
  end

  def test_it_can_find_the_square_root_of_the_quotient
    assert_equal 2.83, @sa.square_root_of_quotient(25, 3)
  end

  def test_it_can_find_the_total_price
    assert_equal 117_201.84, @sa.total_price(@sa.sales_engine.items.all).to_f
  end
end
