require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require 'minitest/autorun'

class InvoiceRepositoryTest < Minitest::Test
	def setup
		@test_helper = TestHelper.new
		invoices = @test_helper.array_of_invoices
		@invoice_repository = InvoiceRepository.new(invoices)
	end

  def test_it_can_be_instantiated
    assert @invoice_repository.instance_of?(InvoiceRepository)
  end

  def test_it_can_return_an_array_of_all_invoices
    assert_equal 3, @invoice_repository.all.count
  end

  def test_it_can_return_an_invoice_id
    assert_equal 1, @invoice_repository.find_by_id(1).id
  end

  def test_it_can_return_a_customer_id
    assert_equal 2, @invoice_repository.find_all_by_customer_id(2).first.customer_id
  end

  def test_it_can_find_all_by_merchant_id
    assert_equal 2, @invoice_repository.find_all_by_merchant_id(12345678).count
  end

  def test_it_can_find_all_by_status
    assert_equal :pending, @invoice_repository.find_all_by_status(:pending).first.status
    assert_equal :shipped, @invoice_repository.find_all_by_status(:shipped).first.status
    assert_equal :returned, @invoice_repository.find_all_by_status(:returned).first.status
  end

  def test_it_monkey_patched_inspect
    assert_equal "#<InvoiceRepository 3 rows>", @invoice_repository.inspect
  end

end
