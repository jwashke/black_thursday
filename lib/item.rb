require 'bigdecimal'
require 'bigdecimal/util'

class Item
  attr_accessor :merchant
  def initialize(info_hash)
    @info = info_hash
  end

  def id
    @info[:id].to_i
  end

  def name
    @info[:name]
  end

  def description
    @info[:description]
  end

  def unit_price
    @info[:unit_price].to_d / 100
  end

  def merchant_id
    @info[:merchant_id].to_i
  end

  def created_at
    Time.parse(@info[:created_at])
  end

  def updated_at
    Time.parse(@info[:updated_at])
  end
end
