require_relative 'test_helper'
require_relative '../lib/customer_repository'
require 'minitest/autorun'

class CustomerRepositoryTest < MiniTest::Test
  def setup
    @test_helper = TestHelper.new
    @customers = @test_helper.array_of_customers
    @customer_repository = CustomerRepository.new(@customers)
  end

  def test_it_can_be_instantiated
    assert @customer_repository.instance_of?(CustomerRepository)
  end

  def test_it_can_return_an_array_of_all_customers
    assert_equal @customers, @customer_repository.all
	end

	def test_it_can_find_customer_by_id
    assert_equal @customers[0], @customer_repository.find_by_id(5)
	end

  def test_it_can_find_all_by_first_name
    assert_equal [@customers[1]], @customer_repository.find_all_by_first_name("Mariah")
  end

  def test_it_can_find_all_by_last_name
    assert_equal [@customers[1]], @customer_repository.find_all_by_last_name("Toy")
  end

  def test_it_returns_empty_array_when_no_customer
		repo = CustomerRepository.new([])
		assert_equal [], repo.all
	end

	def test_it_returns_nil_when_id_is_not_found
		assert_equal nil, @customer_repository.find_by_id("12345678")
	end

	def test_it_returns_an_empty_array_when_find_all_by_first_name_finds_nothing
		assert_equal [], @customer_repository.find_all_by_first_name("Zombocom")
	end

  def test_it_returns_an_empty_array_when_find_all_by_last_name_finds_nothing
    assert_equal [], @customer_repository.find_all_by_last_name("Zombocom")
  end

  def test_inspect_returns_the_class_and_number_of_rows
    assert_equal "#<CustomerRepository 3 rows>", @customer_repository.inspect
  end
end

class CustomerRepository
	attr_accessor :customers
end
