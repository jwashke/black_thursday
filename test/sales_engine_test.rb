require_relative 'test_helper'
require 'minitest/autorun'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
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

end
