require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require 'minitest/autorun'

class InvoiceRepositoryTest < Minitest::Test
	def setup
		@test_helper = TestHelper.new
		@invoices = @test_helper.array_of_invoices
		@invoice_repository = InvoiceRepository.new(@invoices)
	end

  def test_it_can_be_instantiated
    assert @invoice_repository.instance_of?(InvoiceRepository)
  end

  def test_it_can_return_an_array_of_all_invoices
    assert_equal @invoices, @invoice_repository.all
  end

  def test_it_can_return_an_invoice_id
    assert_equal @invoices[0], @invoice_repository.find_by_id(1)
  end

  def test_it_can_return_a_customer_id
    assert_equal [@invoices[0]], @invoice_repository.find_all_by_customer_id(2)
  end

  def test_it_can_find_all_by_merchant_id
    invoices = [@invoices[0], @invoices[2]]
    assert_equal invoices, @invoice_repository.find_all_by_merchant_id(12345678)
  end

  def test_it_can_find_all_by_status
    assert_equal [@invoices[1]], @invoice_repository.find_all_by_status(:pending)
    assert_equal [@invoices[0]], @invoice_repository.find_all_by_status(:shipped)
    assert_equal [@invoices[2]], @invoice_repository.find_all_by_status(:returned)
  end

  def test_it_monkey_patched_inspect
    assert_equal "#<InvoiceRepository 3 rows>", @invoice_repository.inspect
  end

end
