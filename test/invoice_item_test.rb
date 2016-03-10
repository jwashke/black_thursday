require_relative 'test_helper'
require 'minitest/autorun'
require_relative '../lib/invoice_item'

class InvoiceItemTest < MiniTest::Test

  def setup
    @invoice_item = InvoiceItem.new({:id => "6",
                            :item_id     => "7",
                            :invoice_id  => "8",
                            :quantity    => "1",
                            :unit_price  => "1099",
                            :created_at  => "2012-03-27 14:54:09 UTC",
                            :updated_at  => "2012-03-28 14:54:09 UTC"})
  end

  def test_it_can_be_instantiated
    assert @invoice_item.instance_of?(InvoiceItem)
  end

  def test_it_returns_the_integer_id_of_the_invoice_item
    assert_equal 6, @invoice_item.id
  end

  def test_it_returns_the_item_id
    assert_equal 7, @invoice_item.item_id
  end

  def test_it_returns_the_invoice_id
    assert_equal 8, @invoice_item.invoice_id
  end

  def test_it_returns_the_quantity
    assert_equal 1, @invoice_item.quantity
  end

  def test_it_returns_the_unit_price_of_the_invoice_item
    assert_equal 10.99, @invoice_item.unit_price
  end

  def test_it_returns_the_unit_price_of_the_invoice_item_in_dollars
    assert_equal 10.99, @invoice_item.unit_price_to_dollars
  end

  def test_it_returns_a_time_instance_for_time_created
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @invoice_item.created_at
  end

  def test_it_returns_a_time_instance_for_time_updated
    assert_equal Time.parse("2012-03-28 14:54:09 UTC"), @invoice_item.updated_at
  end

  def test_inspect_was_monkey_patched
    assert_equal "#<#{InvoiceItem}>", @invoice_item.inspect
  end
end
