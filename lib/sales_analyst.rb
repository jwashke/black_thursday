require_relative 'sales_engine'


class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    number_of_items = sales_engine.merchants.all.reduce(0) do |sum, merchant|
      sum + merchant.items.length
    end
    (number_of_items / sales_engine.merchants.all.length.to_f).round(2)
  end

  def merchants_with_high_item_count
    average_count = average_items_per_merchant
    standard_deviation_count = average_items_per_merchant_standard_deviation
    sales_engine.merchants.all.select do |merchant|
      merchant.items.count > (average_count + standard_deviation_count)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    grand_total = total_price(merchant.items)
    BigDecimal.new((grand_total / merchant.items.length).round(2))
  end

  def total_price(items)
    items.reduce(0) do |sum_items, item|
      sum_items + item.unit_price
    end
  end

  def average_average_price_per_merchant
    total_average = sales_engine.merchants.all.reduce(0) do |sum_merchants, merchant|
      items_price = total_price(merchant.items)
      if items_price == 0
        sum_merchants
      else
        sum_merchants + (items_price / merchant.items.length)
      end
    end
    average = (total_average / sales_engine.merchants.all.length).round(2)
    BigDecimal.new("#{average}")
  end
#
  def item_price_standard_deviation
    total = total_price(sales_engine.items.all)
    average_price = total / sales_engine.items.all.length
    variance = sales_engine.items.all.reduce(0) do |sum, item|
      sum + (item.unit_price - average_price) ** 2
    end
    Math.sqrt(variance / (sales_engine.items.all.length - 1)).round(2)
  end

  def golden_items
    average_price = average_average_price_per_merchant
    standard_deviation_price = item_price_standard_deviation
    sales_engine.items.all.select do |item|
      item.unit_price > (average_price + 2 * standard_deviation_price)
    end
  end

  def average_invoices_per_merchant
    number_of_invoices = sales_engine.merchants.all.reduce(0) do |sum, merchant|
      sum + merchant.invoices.length
    end
    (number_of_invoices / sales_engine.merchants.all.length.to_f).round(2)
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

  def average_invoices_per_day
    sales_engine.invoices.all.count / 7.0
  end

  def total_invoices_per_day
    days = Hash.new(0)
    sales_engine.invoices.all.map do |invoice|
      days[invoice.created_at.strftime("%A")] += 1 # use %A instead of wday
    end
    days
  end

  def item_price_standard_deviation
    total = total_price(sales_engine.items.all)
    average_price = total / sales_engine.items.all.length
    variance = sales_engine.items.all.reduce(0) do |sum, item|
      sum + (item.unit_price - average_price) ** 2
    end
    Math.sqrt(variance / (sales_engine.items.all.length - 1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    variance = sales_engine.merchants.all.reduce(0) do |sum, merchant|
      sum + (merchant.items.length - average) ** 2
    end
    Math.sqrt(variance / (sales_engine.merchants.all.length - 1)).round(2)
  end

  def average_invoices_per_merchant_standard_deviation

    average = average_invoices_per_merchant
    variance = sales_engine.merchants.all.reduce(0) do |sum, merchant|
      sum + (merchant.invoices.length - average) ** 2
    end
    Math.sqrt(variance / (sales_engine.merchants.all.length - 1)).round(2)
  end

  def average_invoices_per_merchant
    number_of_invoices = sales_engine.merchants.all.reduce(0) do |sum, merchant|
      sum + merchant.invoices.length
    end
    (number_of_invoices / sales_engine.merchants.all.length.to_f).round(2)
  end

  def average_invoices_per_day_standard_deviation
    average = average_invoices_per_day
    variance = total_invoices_per_day.reduce(0) do |sum, day|
      sum + (day[1] - average) ** 2
    end
    Math.sqrt(variance / (total_invoices_per_day.length - 1)).round(2)
  end

  def top_days_by_invoice_count
    average = average_invoices_per_day
    standard_deviation = average_invoices_per_day_standard_deviation
    total_invoices_per_day.map do |day, value|
      day if value > (average + standard_deviation)
    end.compact # removes all nil from array
  end

  def invoice_status(status)
    total = sales_engine.invoices.all.count
    status_total = sales_engine.invoices.find_all_by_status(status).count
    amount = ((status_total / total.to_f) * 100).round(2)
  end

  def total_revenue_by_date(date)
    get_invoices_for_date(date).reduce(0) { |sum, invoice| sum + invoice.total }
  end

  def get_invoices_for_date(date)
    sales_engine.invoices.all.select do |invoice|
      invoice.created_at == date
    end
  end

  def top_revenue_earners(x = 20)
    merchants_ranked_by_revenue[0..(x - 1)]
  end

  def merchants_revenue_array
    sales_engine.merchants.all.map do |merchant|
      revenue = merchant.invoices.map {|invoice| invoice.total }.reduce(:+)
      { :merchant => merchant, :revenue => revenue}
    end
  end

  def merchants_ranked_by_revenue
    merchants_revenue_array.sort_by {|earner| earner[:revenue]}.reverse.map { |hash| hash[:merchant] }
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
    merchants_with_only_one_item.select { |merchant| merchant.created_at.month == Time.parse(month).month }
  end

  def revenue_by_merchant(merchant_id)
    merchant_hash = merchants_revenue_array.find { |hash| hash[:merchant].id == merchant_id }
    merchant_hash[:revenue]
  end

  def successful_invoice_items(merchant_id)
    merchant = sales_engine.merchants.find_by_id(merchant_id)
    invoices = merchant.invoices.select { |invoice| invoice.is_paid_in_full? }
    (invoices.map { |invoice| invoice.invoice_items }).flatten
  end

  def most_sold_item_for_merchant(merchant_id)
    invoice_items = successful_invoice_items(merchant_id).sort_by {|invoice_item| invoice_item.quantity }
    most_sold = invoice_items.select { |invoice_item| invoice_item.quantity == invoice_items.last.quantity }
    most_sold.map { |invoice_item| sales_engine.items.find_by_id(invoice_item.item_id) }
  end

  def best_item_for_merchant(merchant_id)
    invoice_items = successful_invoice_items(merchant_id).sort_by {|invoice_item| invoice_item.unit_price * invoice_item.quantity }
    sales_engine.items.find_by_id(invoice_items.last.item_id)
  end

end
