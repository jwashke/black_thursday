require_relative 'test_helper'
require 'minitest/autorun'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'


class SalesAnalystTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({ :items => "./test/test_data/items.csv", :merchants => "./test/test_data/merchants.csv" })
    @sales_analyst = SalesAnalyst.new(@sales_engine)
  end

  def test_it_can_be_instantiated
    assert @sales_analyst.instance_of?(SalesAnalyst)
  end

  def test_it_has_a_sales_engine_instance
    assert @sales_analyst.sales_engine.instance_of?(SalesEngine)
  end

  def test_it_returns_average_item_per_merchant
    assert_equal 0.82, @sales_analyst.average_items_per_merchant
  end

  def test_it_returns_standard_deviation_per_merchant
    assert_equal 2.19, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_returns_average_item_price_for_merchant
    assert_equal 29.99, @sales_analyst.average_item_price_for_merchant(12334105).to_f
  end
  #
  def test_it_returns_merchants_with_high_item_count
    merchant_names = @sales_analyst.merchants_with_high_item_count.map { |item| item.name }
    assert_equal 6, merchant_names.length
  end

  def test_golden_items
    number_of_items = @sales_analyst.golden_items
    assert_equal 1, number_of_items.length
  end





end
