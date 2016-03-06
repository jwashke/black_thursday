require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    number_of_items = sales_engine.merchant_repository.all.reduce(0) do |sum, merchant|
      sum + merchant.items.length
    end
    (number_of_items / sales_engine.merchant_repository.all.length.to_f).round(2)
  end



  def merchants_with_high_item_count
    average_count = average_items_per_merchant
    standard_deviation_count = average_items_per_merchant_standard_deviation
    sales_engine.merchant_repository.all.select do |merchant|
      merchant.items.count > (average_count + standard_deviation_count)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = sales_engine.merchant_repository.find_by_id(merchant_id)
    grand_total = total_price(merchant.items)
    BigDecimal.new((grand_total / merchant.items.length).round(2))
  end

  def total_price(items)
    items.reduce(0) do |sum_items, item|
      sum_items + item.unit_price
    end
  end

  def average_average_price_per_merchant
    total_average = sales_engine.merchant_repository.all.reduce(0) do |sum_merchants, merchant|
      items_price = total_price(merchant.items)
      if items_price == 0
        sum_merchants
      else
        sum_merchants + (items_price / merchant.items.length)
      end
    end
    average = (total_average / sales_engine.merchant_repository.all.length).round(2)
    BigDecimal.new("#{average}")
  end
#
  def item_price_standard_deviation
    total = total_price(sales_engine.item_repository.all)
    average_price = total / sales_engine.item_repository.all.length
    variance = sales_engine.item_repository.all.reduce(0) do |sum, item|
      sum + (item.unit_price - average_price) ** 2
    end
    Math.sqrt(variance / (sales_engine.item_repository.all.length - 1)).round(2)
  end

  def golden_items
    average_price = average_average_price_per_merchant
    standard_deviation_price = item_price_standard_deviation
    sales_engine.item_repository.all.select do |item|
      item.unit_price > (average_price + 2 * standard_deviation_price)
    end
  end

  def average_invoices_per_merchant
    number_of_invoices = sales_engine.merchant_repository.all.reduce(0) do |sum, merchant|
      sum + merchant.invoices.length
    end
    (number_of_invoices / sales_engine.merchant_repository.all.length.to_f).round(2)
  end

  def top_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    sales_engine.merchant_repository.all.select do |merchant|
      merchant.invoices.length > (average + 2 * standard_deviation)
    end
  end

  def bottom_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    sales_engine.merchant_repository.all.select do |merchant|
      merchant.invoices.length < (average - 2 * standard_deviation)
    end
  end

  #def top_days_by_invoice_count
  #average invoices per day`
  #average invoices per day standard deviation
  #total invoices for each weekday
  #average invoicies sold on each weekday
  #which weekday has an average higher than one standard deviation above the average per day

  def average_invoices_per_day
    sales_engine.invoice_repository.all.count / 7.0
  end

  def total_invoices_per_day
    days = Hash.new(0)
    sales_engine.invoice_repository.all.map do |invoice|
      days[invoice.created_at.strftime("%A")] += 1 # use %A instead of wday
    end
    days
  end

  def item_price_standard_deviation
    total = total_price(sales_engine.item_repository.all)
    average_price = total / sales_engine.item_repository.all.length
    variance = sales_engine.item_repository.all.reduce(0) do |sum, item|
      sum + (item.unit_price - average_price) ** 2
    end
    Math.sqrt(variance / (sales_engine.item_repository.all.length - 1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    variance = sales_engine.merchant_repository.all.reduce(0) do |sum, merchant|
      sum += (merchant.items.length - average) ** 2
    end
    Math.sqrt(variance / (sales_engine.merchant_repository.all.length - 1)).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    variance = sales_engine.merchant_repository.all.reduce(0) do |sum, merchant|
      sum += (merchant.invoices.length - average) ** 2
    end
    Math.sqrt(variance / (sales_engine.merchant_repository.all.length - 1)).round(2)
  end

  def average_invoices_per_day_standard_deviation
    average = average_invoices_per_day
    variance = total_invoices_per_day.reduce(0) do |sum, day|
      sum += (day[1] - average) ** 2
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








end

# sales_engine = SalesEngine.from_csv({
#     :items     => "./data/items.csv",
#     :merchants => "./data/merchants.csv"
#   })

# sa = SalesAnalyst.new(sales_engine)
#  puts sa.average_items_per_merchant_standard_deviation


# puts sa.merchants_with_high_item_count
# puts sa.average_item_price_for_merchant(4)
# puts sa.average_average_price_per_merchant
# puts sa.golden_items
