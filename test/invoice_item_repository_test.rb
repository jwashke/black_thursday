require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require 'minitest/autorun'

class InvoiceItemRepositoryTest < MiniTest::Test
  def setup
    @test_helper = TestHelper.new
    invoice_items = @test_helper.array_of_invoice_items
    @invoice_item_repo = InvoiceItemRepository.new(invoice_items)
  end

  def test_it_can_return_an_array_of_all_invoice_items
    assert_equal 3, @invoice_item_repo.all.count
  end

  def test_it_can_return_an_invoice_item_by_id
    assert_equal 1, @invoice_item_repo.find_by_id(1).id
  end

  def test_it_can_return_nil_when_invoice_item_id_not_found
    assert_equal nil, @invoice_item_repo.find_by_id(7)
  end

  def test_it_can_return_all_invoice_items_with_matching_item_id
    assert_equal 2, @invoice_item_repo.find_all_by_item_id(2).count
  end

  def test_it_returns_an_empty_array_when_no_item_id_is_found
    assert_equal [], @invoice_item_repo.find_all_by_item_id(7)
  end

  def test_it_can_return_all_invoice_items_with_matching_invoice_id
    assert_equal 2, @invoice_item_repo.find_all_by_invoice_id(4).count
  end

  def test_it_returns_an_empty_array_when_no_invoice_id_is_found
    assert_equal [], @invoice_item_repo.find_all_by_invoice_id(7)
  end

  def test_inspect_returns_the_class_and_number_of_rows
    assert_equal "#<InvoiceItemRepository 3 rows>", @invoice_item_repo.inspect
  end


end
