require_relative 'test_helper'
require 'minitest/autorun'
require "minitest/pride"
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

class MerchantAnalysisTest < Minitest::Test
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

  def test_it_returns_average_item_per_merchant
    assert_equal 0.84, @sa.average_items_per_merchant
  end

  def test_it_returns_standard_deviation_for_items_per_merchant
    assert_equal 2.18, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_returns_average_item_price_for_merchant
    assert_equal 29.99, @sa.average_item_price_for_merchant(12334105).to_f
  end
  #
  def test_it_returns_merchants_with_high_item_count
    merchant_names = @sa.merchants_with_high_item_count.map { |item| item.name }
    assert_equal 6, merchant_names.length
  end

  def test_it_returns_average_invoices_per_merchant
    assert_equal 0.19, @sa.average_invoices_per_merchant
  end

  def test_it_returns_standard_deviation_for_invoices_per_merchant
    assert_equal 0.42, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_returns_merchants_more_than_two_standard_deviations_above_mean
    assert_equal 1, @sa.top_merchants_by_invoice_count.length
  end

  def test_it_returns_merchants_less_than_two_standard_deviations_below_mean
    assert_equal 0, @sa.bottom_merchants_by_invoice_count.length
  end

  def test_it_returns_top_performing_merchants_by_revenue
    assert_equal 5, @sa.top_revenue_earners(5).count
  end

  def test_the_top_performing_merchants_returns_20_by_default
    assert_equal 20, @sa.top_revenue_earners.count
  end

  def test_it_returns_merchants_with_pending_invoices
    assert_equal 20, @sa.merchants_with_pending_invoices.count
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

  def test_it_returns_an_array_of_successful_items
    assert_equal [], @sa.successful_items(12334207)
  end

  def test_it_returns_all_merchants_and_their_revenue
    assert_equal 109, @sa.merchants_revenue_array.count
  end

  def test_it_returns_the_average_average_price_per_merchant
    assert_equal 977.76, @sa.average_average_price_per_merchant.to_f
  end

  def test_it_returns_merchants_ranked_by_revenue
    assert_equal 20, @sa.merchants_ranked_by_revenue.count
  end
end
