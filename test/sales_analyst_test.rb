require_relative 'test_helper'
require 'minitest/autorun'
require "minitest/pride"
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'


class SalesAnalystTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({ :items     => "./test/test_data/items.csv",
                                           :merchants => "./test/test_data/merchants.csv",
                                           :customer  => "./test/test_data/merchants.csv",
                                           :invoices  => "./test/test_data/invoices.csv" })
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

  def test_it_returns_standard_deviation_for_items_per_merchant
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

  def test_it_returns_average_invoices_per_merchant
    assert_equal 0.19, @sales_analyst.average_invoices_per_merchant
  end

  def test_it_returns_standard_deviation_for_invoices_per_merchant
    assert_equal 0.41, @sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_it_returns_merchants_more_than_two_standard_deviations_above_mean
    assert_equal 1, @sales_analyst.top_merchants_by_invoice_count.length
  end

  def test_it_returns_merchants_less_than_two_standard_deviations_below_mean
    assert_equal 0, @sales_analyst.bottom_merchants_by_invoice_count.length
  end

  def test_it_returns_the_percentage_of_invoices_with_a_given_status
    assert_equal 63, @sales_analyst.invoice_status(:shipped).round(2)
    assert_equal 29.0, @sales_analyst.invoice_status(:pending).round(2)
    assert_equal 8.0, @sales_analyst.invoice_status(:returned).round(2)
  end

  def test_it_returns_total_invoices_per_day
    expected = {"Saturday"=>15, "Friday"=>19, "Wednesday"=>9,
                "Monday"  =>17, "Sunday"=>12, "Tuesday"  =>16,
                "Thursday"=>12}
    assert_equal expected, @sales_analyst.total_invoices_per_day
  end

  def test_it_returns_top_days_by_invoice_count
    assert_equal ["Friday"], @sales_analyst.top_days_by_invoice_count
  end

end
