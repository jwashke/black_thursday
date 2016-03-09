require_relative 'test_helper'
require 'minitest/autorun'
require "minitest/pride"
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

class InvoiceAnalysisTest < Minitest::Test
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

  def test_it_returns_average_invoices_per_day
    assert_equal 14.29, @sa.average_invoices_per_day
  end

  def test_it_returns_average_invoices_per_day_standard_deviation
    assert_equal 3.45, @sa.average_invoices_per_day_standard_deviation
  end

  def test_it_returns_percentage_of_invoices_by_status
    assert_equal 63.0, @sa.invoice_status(:shipped)
    assert_equal 29.0, @sa.invoice_status(:pending)
  end

  def test_it_returns_the_total_revenue_by_date
    assert_equal 0, @sa.total_revenue_by_date(Time.parse("2008-04-04"))
  end

  def test_it_returns_invoices_for_given_date
    assert_equal 1, @sa.get_invoices_for_date(Time.parse("2009-02-07")).count
  end
end
