require_relative 'merchant'

class MerchantRepository

  def initialize(merchants)
    @merchants = populate_merchants_array(merchants)
  end

  def populate_merchants_array(merchants)
    merchants.map { |merchant| Merchant.new(merchant) }
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @merchants.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    @merchants.select do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
