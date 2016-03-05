require_relative 'test_helper'
require_relative '../lib/item_repository'
require 'minitest/autorun'

class CustomerRepositoryTest < MiniTest::Test
  def setup
    @test_helper = TestHelper.new
    @items = @test_helper.array_of_items
    @item_repository = ItemRepository.new(@items)
  end

  def test_it_can_be_instantiated
    assert @item_repository.instance_of?(ItemRepository)
  end

  def test_it_can_return_an_array_of_all_items
    assert_equal @items, @item_repository.all
	end

	def test_it_can_find_item_by_id
    assert_equal @items[0], @item_repository.find_by_id(263395237)
	end

	def test_it_can_find_item_by_name
		assert_equal @items[0], @item_repository.find_by_name("Country Ham")
	end

  def test_it_can_find_all_by_description
    items = [@items[0], @items[2]]
    assert_equal items, @item_repository.find_all_with_description("Delicious")
  end

  def test_find_all_by_description_is_case_insensitive
    items = [@items[0], @items[2]]
    assert_equal items, @item_repository.find_all_with_description("DeLiCIOUS")
  end

  def test_it_can_find_all_by_price
    items = [@items[0]]
    assert_equal items, @item_repository.find_all_by_price(10.99)
  end

  def test_it_can_find_all_by_price_in_range
		items = [@items[0], @items[2]]
		assert_equal items, @item_repository.find_all_by_price_in_range(10.99..15.99)
	end

  def test_it_can_find_all_by_merchant_id
		items = [@items[1]]
		assert_equal items, @item_repository.find_all_by_merchant_id(55555555)
	end

	def test_it_returns_empty_array_when_no_item
		repo = ItemRepository.new([])
		assert_equal [], repo.all
	end

	def test_it_returns_nil_when_id_is_not_found
		assert_equal nil, @item_repository.find_by_id("12345678")
	end

	def test_it_returns_nil_when_name_is_not_found
		assert_equal nil, @item_repository.find_by_name("Ships and things")
	end

	def test_it_returns_an_empty_array_when_find_all_by_description_finds_nothing
		assert_equal [], @item_repository.find_all_with_description("Unsavory")
	end

  def test_it_returns_an_empty_array_when_find_all_by_price_finds_nothing
    assert_equal [], @item_repository.find_all_by_price(100.00)
  end

  def test_it_returns_an_empty_array_when_find_all_by_price_in_range_finds_nothing
    assert_equal [], @item_repository.find_all_by_price_in_range(100.00..101.00)
  end

  def test_it_returns_an_empty_array_when_find_all_by_merchant_id_finds_nothing
    assert_equal [], @item_repository.find_all_by_merchant_id(87654321)
  end
end

class ItemRepository
	attr_accessor :items
end
