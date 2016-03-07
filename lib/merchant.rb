class Merchant
  attr_accessor :items,
                :invoices,
                :customers

  def initialize(info_hash)
    @info = info_hash
  end

  def id
    @info[:id].to_i
  end

  def name
    @info[:name]
  end

  def inspect
    "#<#{self.class}>"
  end
end
