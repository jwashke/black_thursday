require_relative 'test_helper'
require_relative '../lib/customer'
require 'minitest/autorun'

class CustomerTest < Minitest::Test
  def setup
    @time = Time.now
    @customer = Customer.new({
      :id         => "6",
      :first_name => "Joan",
      :last_name  => "Clarke",
      :created_at  => @time.to_s,
      :updated_at  => @time.to_s
      })
  end

  def test_it_can_be_instantiated
    assert @customer.instance_of?(Customer)
  end

  def test_it_can_return_its_id
    assert_equal 6, @customer.id
  end

  def test_it_can_return_its_first_name
    assert_equal "Joan", @customer.first_name
  end

  def test_it_can_return_its_last_name
    assert_equal "Clarke", @customer.last_name
  end

  def test_it_returns_the_time_created_at
    assert_equal @time.to_s, @customer.created_at.to_s
  end

  def test_it_returns_the_time_last_updated
    assert_equal @time.to_s, @customer.updated_at.to_s
  end
end
