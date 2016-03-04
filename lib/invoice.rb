class Invoice
  attr_accessor :merchant

  def initialize(info_hash)
    @info = info_hash
  end

  def id
    @info[:id].to_i
  end

  def customer_id
    @info[:customer_id].to_i
  end

  def merchant_id
    @info[:merchant_id].to_i
  end

  def status
    @info[:status].to_sym
  end

  def created_at
    Time.parse(@info[:created_at])
  end

  def updated_at
    Time.parse(@info[:updated_at])
  end
end
