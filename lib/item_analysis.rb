module ItemAnalysis
  
  def golden_items
    average_price = average_average_price_per_merchant
    standard_deviation_price = item_price_standard_deviation
    sales_engine.items.all.select do |item|
      item.unit_price > (average_price + 2 * standard_deviation_price)
    end
  end

  def item_price_standard_deviation
    total = total_price(sales_engine.items.all)
    average_price = total / sales_engine.items.all.length
    variance = sales_engine.items.all.reduce(0) do |sum, item|
      sum + (item.unit_price - average_price) ** 2
    end
    Math.sqrt(variance / (sales_engine.items.all.length - 1)).round(2)
  end
end
