require_relative 'test_helper'
require_relative '../lib/item'
require 'minitest/autorun'
require 'bigdecimal'

class ItemTest < Minitest::Test
  def setup
    @time = Time.now
    @item = Item.new({
      :id          => "263395237",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1099",
      :merchant_id => "12334141",
      :created_at  => @time.to_s,
      :updated_at  => @time.to_s
      })
  end

  def test_it_can_be_instantiated
    assert @item.instance_of?(Item)
  end

  def test_it_returns_the_id_of_the_item_as_an_integer
    assert_equal 263395237, @item.id
  end

  def test_it_returns_the_name_of_the_item
    assert_equal "Pencil", @item.name
  end

  def test_it_returns_the_item_description
    assert_equal "You can use it to write things", @item.description
  end

  def test_it_returns_the_unit_price_of_the_item
    assert_equal 10.99, @item.unit_price
  end

  def test_it_returns_merchant_id_of_the_item_as_an_integer
    assert_equal 12334141, @item.merchant_id
  end

  def test_it_returns_the_time_created_at
    assert_equal @time.to_s, @item.created_at.to_s
  end

  def test_it_returns_the_time_last_updated
    assert_equal @time.to_s, @item.updated_at.to_s
  end

  def test_inspect_was_monkey_patched
    assert_equal "#<#{Item}>", @item.inspect
  end
end
