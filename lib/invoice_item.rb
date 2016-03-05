require 'bigdecimal'
require 'bigdecimal/util'

class InvoiceItem
  attr_accessor :merchant

  def initialize(info_hash)
    @info = info_hash
  end

  def id
    @info[:id].to_i
  end

  def item_id
    @info[:item_id].to_i
  end

  def invoice_id
    @info[:invoice_id].to_i
  end

  def quantity
    @info[:quantity].to_i
  end

  def unit_price
    @info[:unit_price].to_d / 100
  end

  def unit_price_to_dollars
    @info[:unit_price].to_f / 100
  end

  def created_at
    Time.parse(@info[:created_at])
  end

  def updated_at
    Time.parse(@info[:updated_at])
  end
end
