require_relative 'test_helper'
require 'minitest/autorun'
require_relative '../lib/invoice'

class InvoiceTest < MiniTest::Test

  def setup
    @invoice = Invoice.new({:id => "1",
                            :customer_id => "2",
                            :merchant_id => "12345678",
                            :status      => "Shipped",
                            :created_at  => "2012-03-27 14:54:09 UTC",
                            :updated_at  => "2012-03-28 14:54:09 UTC"})
  end

  def test_it_can_be_instantiated
    assert @invoice.instance_of?(Invoice)
  end

  def test_it_returns_the_integer_id_of_the_invoice
    assert_equal 1, @invoice.id
  end

  def test_it_returns_the_customer_id
    assert_equal 2, @invoice.customer_id
  end

  def test_it_returns_the_merchant_id
    assert_equal 12345678, @invoice.merchant_id
  end

  def test_it_returns_the_status
    assert_equal "Shipped", @invoice.status
  end

  def test_it_returns_a_time_instance_for_time_created
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @invoice.created_at
  end

  def test_it_returns_a_time_instance_for_time_updated
    assert_equal Time.parse("2012-03-28 14:54:09 UTC"), @invoice.updated_at
  end
end
