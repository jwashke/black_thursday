require_relative 'test_helper'
require_relative '../lib/transaction_repository'
require 'minitest/autorun'

class TransactionRepositoryTest < MiniTest::Test
  def setup
    @test_helper = TestHelper.new
    @transactions = @test_helper.array_of_transactions
    @transaction_repo = TransactionRepository.new(@transactions)
  end

  def test_it_can_be_instantiated
    assert @transaction_repo.instance_of?(TransactionRepository)
  end

  def test_it_can_return_an_array_of_all_transactions
    assert_equal @transactions, @transaction_repo.all
  end

  def test_it_can_return_a_transaction_by_id
    assert_equal @transactions[0], @transaction_repo.find_by_id(6)
  end

  def test_it_can_return_nil_when_transaction_id_not_found
    assert_equal nil, @transaction_repo.find_by_id(1)
  end

  def test_it_can_return_all_transactions_with_matching_invoice_id
    transactions = [@transactions[0], @transactions[1]]
    assert_equal transactions, @transaction_repo.find_all_by_invoice_id(8)
  end

  def test_it_returns_an_empty_array_when_no_invoice_id_is_found
    assert_equal [], @transaction_repo.find_all_by_invoice_id(1)
  end

  def test_it_can_return_all_transactions_with_matching_credit_card_number
    transactions = [@transactions[0], @transactions[1]]
    assert_equal transactions, @transaction_repo.find_all_by_credit_card_number(4242424242424242)
  end

  def test_it_returns_an_empty_array_when_credit_card_number_not_found
    assert_equal [], @transaction_repo.find_all_by_credit_card_number(22222222222222222)
  end

  def test_it_can_find_all_transactions_by_result_success
    transactions = [@transactions[0], @transactions[1]]
    assert_equal transactions, @transaction_repo.find_all_by_result("success")
  end

  def test_it_can_find_all_transactions_by_result_failed
    transactions = [@transactions[2]]
    assert_equal transactions, @transaction_repo.find_all_by_result("failed")
  end

  def test_it_returns_an_empty_error_when_result_not_found
    assert_equal [], @transaction_repo.find_all_by_result("pending")
  end
end
