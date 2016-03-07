class Invoice
  attr_accessor :merchant,
                :items,
                :customer,
                :transactions,
                :invoice_items

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

  def is_paid_in_full?
    return if transactions.nil?
    transactions.any? {|transaction| transaction.result == "success"}
  end

  def total
    return 0 if invoice_items.nil?
    return 0 unless is_paid_in_full?
    invoice_items.reduce(0) do |sum, invoice_item|
      sum + invoice_item.unit_price_to_dollars * invoice_item.quantity
    end.to_d
  end

  def inspect
    "#<#{self.class}>"
  end
end
