require_relative 'test_helper'
require 'minitest/autorun'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @test_helper = TestHelper.new
    @sales_engine = SalesEngine.new({ :merchants => [], :items => [] })
  end

  def test_it_can_be_instantiated
    assert @sales_engine.instance_of?(SalesEngine)
  end

  def test_it_has_a_item_repository
    assert @sales_engine.items.instance_of?(ItemRepository)
  end

  def test_it_has_a_merchant_repository
    assert @sales_engine.merchants.instance_of?(MerchantRepository)
  end

  def test_it_populates_item_repository_with_an_item_object
    hash = @test_helper.sample_item_hash_info
    assert @sales_engine.populate_item_repository(hash).items[0].instance_of?(Item)
  end

  def test_it_populates_item_repository_with_item_id
    assert_equal @test_helper.sample_item_object[0].id, @sales_engine.populate_item_repository(@test_helper.sample_item_hash_info).items[0].id
  end

  def test_it_populates_item_repository_with_item_name
    assert_equal @test_helper.sample_item_object[0].name, @sales_engine.populate_item_repository(@test_helper.sample_item_hash_info).items[0].name
  end

  def test_it_populates_item_repository_with_item_description
    assert_equal @test_helper.sample_item_object[0].description, @sales_engine.populate_item_repository(@test_helper.sample_item_hash_info).items[0].description
  end

  def test_it_populates_item_repository_with_item_unit_price
    assert_equal @test_helper.sample_item_object[0].unit_price, @sales_engine.populate_item_repository(@test_helper.sample_item_hash_info).items[0].unit_price
  end

  def test_it_populates_item_repository_with_item_merchant_id
    assert_equal @test_helper.sample_item_object[0].merchant_id, @sales_engine.populate_item_repository(@test_helper.sample_item_hash_info).items[0].merchant_id
  end

  def test_it_populates_merchant_repository_with_a_merchant_object
     assert @sales_engine.populate_merchant_repository(@test_helper.sample_merchant_hash_info).merchants[0].instance_of?(Merchant)
  end

  def test_it_populates_merchant_repository_with_a_merchant_id
     assert_equal @test_helper.sample_merchant_object[0].id, @sales_engine.populate_merchant_repository(@test_helper.sample_merchant_hash_info).merchants[0].id
  end

  def test_it_populates_merchant_repository_with_a_merchant_name
     assert_equal @test_helper.sample_merchant_object[0].name, @sales_engine.populate_merchant_repository(@test_helper.sample_merchant_hash_info).merchants[0].name
  end

  def test_it_connects_items_to_merchant
    @sales_engine.populate_item_repository(@test_helper.sample_item_hash_info)
    @sales_engine.populate_merchant_repository(@test_helper.sample_merchant_hash_info)
    @sales_engine.connect_items_to_merchant
    #items.instance_of?(Item)

  end

end

class SalesEngine
  attr_accessor :items, :merchants
end
