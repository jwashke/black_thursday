module MerchantAnalysis

  def average_items_per_merchant
    total_items = sales_engine.merchants.all.reduce(0) do |sum, merchant|
      sum + merchant.items.length
    end
    average(total_items, sales_engine.merchants.all.length)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    variance = sales_engine.merchants.all.reduce(0) do |sum, merchant|
      sum + (merchant.items.length - average) ** 2
    end
    square_root_of_quotient(variance, sales_engine.merchants.all.length - 1)
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    total = total_price(merchant.items)
    items = merchant.items.length
    average(total, items)
  end

  def merchants_with_high_item_count
    average_count = average_items_per_merchant
    standard_deviation_count = average_items_per_merchant_standard_deviation
    sales_engine.merchants.all.select do |merchant|
      merchant.items.count > (average_count + standard_deviation_count)
    end
  end

  def average_invoices_per_merchant
    total_invoices = sales_engine.merchants.all.reduce(0) do |sum, merchant|
      sum + merchant.invoices.length
    end
    average(total_invoices, sales_engine.merchants.all.length)
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    variance = sales_engine.merchants.all.reduce(0) do |sum, merchant|
      sum + (merchant.invoices.length - average) ** 2
    end
    square_root_of_quotient(variance, sales_engine.merchants.all.length - 1)
  end

  def top_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    sales_engine.merchants.all.select do |merchant|
      merchant.invoices.length > (average + 2 * standard_deviation)
    end
  end

  def bottom_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    sales_engine.merchants.all.select do |merchant|
      merchant.invoices.length < (average - 2 * standard_deviation)
    end
  end

  def merchants_ranked_by_revenue
    sorted_merchants_revenue_array.reverse.map do |hash|
      hash[:merchant]
    end
  end

  def sorted_merchants_revenue_array
    array = merchants_revenue_array.reject { |hash| hash[:revenue].nil? }
    array.sort_by do |hash|
      hash[:revenue]
    end
  end
  def top_revenue_earners(x = 20)
    merchants_ranked_by_revenue[0..(x - 1)]
  end

  def merchants_with_pending_invoices
    pending = sales_engine.merchants.all.select do |merchant|
      merchant.invoices.any?{ |invoice| !invoice.is_paid_in_full? }
    end
  end

  def merchants_with_only_one_item
    sales_engine.merchants.all.select do |merchant|
      merchant.items.count == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.select do |merchant|
      merchant.created_at.month == Time.parse(month).month
    end
  end

  def best_item_for_merchant(merchant_id)
    invoice_items = successful_items(merchant_id).sort_by do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
    return 0 if invoice_items.last.nil?
    sales_engine.items.find_by_id(invoice_items.last.item_id)
  end

  def most_sold_item_for_merchant(merchant_id)
    invoice_items = successful_items(merchant_id).sort_by do |invoice_item|
      invoice_item.quantity
    end
    most_sold = invoice_items.select do |invoice_item|
      invoice_item.quantity == invoice_items.last.quantity
    end
    most_sold.map do |invoice_item|
      sales_engine.items.find_by_id(invoice_item.item_id)
    end
  end

  def average_average_price_per_merchant
    total_average = sales_engine.merchants.all.reduce(0) do |sum, merchant|
      items_price = total_price(merchant.items)
      items_price == 0 ? sum : sum + average(items_price, merchant.items.length)
    end
    average(total_average, sales_engine.merchants.all.length)
  end

  def average_invoices_per_merchant
    number_of_invoices = sales_engine.merchants.all.reduce(0) do |sum, merchant|
      sum + merchant.invoices.length
    end
    (number_of_invoices / sales_engine.merchants.all.length.to_f).round(2)
  end

  def merchants_revenue_array
    sales_engine.merchants.all.map do |merchant|
      revenue = merchant.invoices.map {|invoice| invoice.total }.reduce(:+)
      { :merchant => merchant, :revenue => revenue}
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant_hash = merchants_revenue_array.find do |hash|
      hash[:merchant].id == merchant_id
    end
    merchant_hash[:revenue].nil? ? 0 : merchant_hash[:revenue]
  end

  def successful_items(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    invoices = merchant.invoices.select { |invoice| invoice.is_paid_in_full? }
    (invoices.map { |invoice| invoice.invoice_items }).flatten
  end

  def merchant_names_sorted_by_revenue
    sorted_merchants_revenue_array.map do |hash|
      hash[:merchant].name
    end
  end

  def merchants_revenue_hash
    sorted_merchants_revenue_array.map do |hash|
      hash[:revenue]
    end
  end

  def item_names_for_top_merchant
    sorted_merchants_revenue_array[0].items.map do |item|
      item.name
    end
  end

  def item_prices_for_top_merchant
    sorted_merchants_revenue_array[0].items.map do |item|
      item.unit_price
    end
  end
end
