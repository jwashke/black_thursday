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

  def test_it_has_a_sales_engine_instance
    assert @sa.sales_engine.instance_of?(SalesEngine)
  end

  def test_it_returns_average_item_per_merchant
    assert_equal 0.85, @sa.average_items_per_merchant
  end

  def test_it_returns_standard_deviation_for_items_per_merchant
    assert_equal 2.19, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_returns_average_item_price_for_merchant
    assert_equal 29.99, @sa.average_item_price_for_merchant(12334105).to_f
  end
  #
  def test_it_returns_merchants_with_high_item_count
    merchant_names = @sa.merchants_with_high_item_count.map { |item| item.name }
    assert_equal 6, merchant_names.length
  end

  def test_golden_items
    number_of_items = @sa.golden_items
    assert_equal 1, number_of_items.length
  end

  def test_it_returns_average_invoices_per_merchant
    assert_equal 0.19, @sa.average_invoices_per_merchant
  end

  def test_it_returns_standard_deviation_for_invoices_per_merchant
    assert_equal 0.41, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_returns_merchants_more_than_two_standard_deviations_above_mean
    assert_equal 1, @sa.top_merchants_by_invoice_count.length
  end

  def test_it_returns_merchants_less_than_two_standard_deviations_below_mean
    assert_equal 0, @sa.bottom_merchants_by_invoice_count.length
  end

  def test_it_returns_the_percentage_of_invoices_with_a_given_status
    assert_equal 63, @sa.invoice_status(:shipped).round(2)
    assert_equal 29.0, @sa.invoice_status(:pending).round(2)
    assert_equal 8.0, @sa.invoice_status(:returned).round(2)
  end

  def test_it_returns_total_invoices_per_day
    expected = {"Saturday"=>15, "Friday"=>19, "Wednesday"=>9,
                "Monday"  =>17, "Sunday"=>12, "Tuesday"  =>16,
                "Thursday"=>12}
    assert_equal expected, @sa.total_invoices_per_day
  end

  def test_it_returns_top_days_by_invoice_count
    assert_equal ["Friday"], @sa.top_days_by_invoice_count
  end

  def test_it_returns_the_item_price_standard_deviation
    assert_equal 8901.79, @sa.item_price_standard_deviation
  end

  def test_it_returns_average_invoices_per_merchant
    assert_equal 0.19, @sa.average_invoices_per_merchant
  end

  def test_it_returns_the_total_revenue_by_date
    assert_equal 0, @sa.total_revenue_by_date(Time.parse("2000-05-28")).to_f
  end

  def test_it_returns_top_performing_merchants_by_revenue
    assert_equal 5, @sa.top_revenue_earners(5).count
  end

  def test_it_returns_merchants_with_pending_invoices
    assert_equal 19, @sa.merchants_with_pending_invoices.count
  end

  def test_it_returns_merchants_that_offer_only_one_item
    assert_equal 26, @sa.merchants_with_only_one_item.count
  end

  def test_it_returns_merchants_selling_one_item_month_registered
    assert_equal 2, @sa.merchants_with_only_one_item_registered_in_month("May").count
  end

  def test_it_returns_total_revenue_for_single_merchant
    assert_equal 0, @sa.revenue_by_merchant(12334159)
  end

  def test_it_returns_most_sold_item_for_merchant
    assert_equal [], @sa.most_sold_item_for_merchant(12334207)
  end

  def test_it_returns_best_item_for_merchant
    assert_equal 0, @sa.best_item_for_merchant(12334207)
  end
end
