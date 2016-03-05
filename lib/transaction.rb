class Transaction
  def initialize(info)
    @info = info
  end

  def id
    @info[:id].to_i
  end

  def invoice_id
    @info[:invoice_id].to_i
  end

  def credit_card_number
    @info[:credit_card_number].to_i
  end

  def credit_card_expiration_date
    @info[:credit_card_expiration_date]
  end

  def result
    @info[:result]
  end

  def created_at
    Time.parse(@info[:created_at])
  end

  def updated_at
    Time.parse(@info[:updated_at])
  end
end
