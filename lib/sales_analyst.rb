require_relative 'sales_engine'
require_relative 'merchant_analysis'
require_relative 'item_analysis'
require_relative 'invoice_analysis'
require_relative 'charts'

class SalesAnalyst
  include MerchantAnalysis
  include InvoiceAnalysis
  include ItemAnalysis

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average(total, number)
    (total / number.to_f).round(2)
  end

  def square_root_of_quotient(variance, total)
    Math.sqrt(variance / total).round(2)
  end

  def total_price(items)
    items.reduce(0) do |sum_items, item|
      sum_items + item.unit_price
    end
  end
end
