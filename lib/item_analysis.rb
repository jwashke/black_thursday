module ItemAnalysis

  def golden_items
    average_price = average_average_price_per_merchant
    sales_engine.items.all.select do |item|
      item.unit_price > (average_price + 2 * item_price_standard_deviation)
    end
  end

  def golden_items_name_array
    golden_items.map do |item|
      item.name
    end
  end

  def golden_items_price_array
    golden_items.map do |item|
      item.unit_price
    end
  end

  def item_price_standard_deviation
    total = total_price(sales_engine.items.all)
    average = average(total, sales_engine.items.all.length)
    variance = sales_engine.items.all.reduce(0) do |sum, item|
      sum + (item.unit_price - average) ** 2
    end
    square_root_of_quotient(variance, sales_engine.items.all.length - 1)
  end
end
