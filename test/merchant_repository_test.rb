require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require 'minitest/autorun'

class MerchantRepositoryTest < Minitest::Test
	def setup
		@test_helper = TestHelper.new
		@merchant_repository = MerchantRepository.new
		@merchant_repository.merchants = @test_helper.array_of_merchants
	end

	def test_it_can_be_instantiated
		assert @merchant_repository.instance_of?(MerchantRepository)
	end

	def test_it_can_return_an_array_of_all_merchants
		assert_equal @test_helper.array_of_merchants, @merchant_repository.all
	end

	def test_it_can_find_merchant_by_id
		assert_equal @test_helper.array_of_merchants[0], @merchant_repository.find_by_id("11111111")
	end

	def test_it_can_find_merchant_by_name
		assert_equal @test_helper.array_of_merchants[0], @merchant_repository.find_by_name("Virginia Hams")
	end

	def test_it_can_find_all_by_name
		merchants = [@test_helper.array_of_merchants[0], @test_helper.array_of_merchants[2]]
		assert_equal merchants, @merchant_repository.find_all_by_name("Hams")
	end

	def test_it_returns_empty_array_when_no_merchant
		repo = MerchantRepository.new
		assert_equal [], repo.all
	end

	def test_it_returns_nil_when_id_is_not_found
		assert_equal nil, @merchant_repository.find_by_id("12345678")
	end

	def test_it_returns_nil_when_name_is_not_found
		assert_equal nil, @merchant_repository.find_by_name("Ships and things")
	end

	def test_it_returns_an_empty_array_when_find_all_finds_nothing
		assert_equal [], @merchant_repository.find_all_by_name("Ship")
	end
end