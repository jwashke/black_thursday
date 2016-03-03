
class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    number_of_items = @sales_engine.merchants.all.reduce(0) do |sum, merchant|
      sum + merchant.items.length
    end
    # require 'pry'
    # binding.pry
    (number_of_items / @sales_engine.merchants.all.length.to_f).round(2)
  end

end
