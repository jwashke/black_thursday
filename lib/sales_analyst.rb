require_relative 'sales_engine'
require_relative 'merchant_analysis'
require_relative 'item_analysis'
require_relative 'invoice_analysis'

class SalesAnalyst
  include MerchantAnalysis
  include InvoiceAnalysis
  include ItemAnalysis

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end
end
