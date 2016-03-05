class TransactionRepository
  def initialize(transactions)
    @transactions = transactions
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(id)
    @transactions.select { |transaction| transaction.invoice_id == id }
  end

  def find_all_by_credit_card_number(number)
    @transactions.select do |transaction|
      transaction.credit_card_number == number
    end
  end

  def find_all_by_result(result)
    @transactions.select { |transaction| transaction.result == result }
  end

  def inspect
   "#<#{self.class} #{@transactions.size} rows>"
 end
end
