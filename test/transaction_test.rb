require_relative 'test_helper'
require 'minitest/autorun'
require_relative '../lib/transaction'

class TransactionTest < MiniTest::Test

  def setup
    @transaction = Transaction.new({ :id                          => "6",
                                     :invoice_id                  => "8",
                                     :credit_card_number          => "4242424242424242",
                                     :credit_card_expiration_date => "0220",
                                     :result                      => "success",
                                     :created_at                  => "2012-03-27 14:54:09 UTC",
                                     :updated_at                  => "2012-03-28 14:54:09 UTC" })
  end

  def test_it_can_be_instantiated
    assert @transaction.instance_of?(Transaction)
  end

  def test_it_returns_the_integer_id_of_the_transaction
    assert_equal 6, @transaction.id
  end

  def test_it_returns_the_invoice_id
    assert_equal 8, @transaction.invoice_id
  end

  def test_it_returns_the_credit_card_number
    assert_equal 4242424242424242, @transaction.credit_card_number
  end

  def test_it_returns_the_credit_card_expiration_date
    assert_equal "0220", @transaction.credit_card_expiration_date
  end

  def test_it_returns_the_result_of_the_transaction
    assert_equal "success", @transaction.result
  end

  def test_it_returns_a_time_instance_for_time_created
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @transaction.created_at
  end

  def test_it_returns_a_time_instance_for_time_updated
    assert_equal Time.parse("2012-03-28 14:54:09 UTC"), @transaction.updated_at
  end
end
