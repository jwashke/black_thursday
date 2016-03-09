require 'googlecharts'
require_relative 'sales_engine'
require_relative 'sales_analyst'

class Charts

  def initialize(sa)
    @sa = sa
    make_graphs
  end

  def make_graphs
    top_5_merchants_pie_chart
    golden_items_pie_chart
    top_merchant_items_graph
  end

  def top_5_merchants_pie_chart
    graph = Gchart.pie_3d(:title  => 'Top 20 Merchants by Revenue',
                          :size   => '600x300',
                          :data   => @sa.merchants_revenue_hash[0..19],
                          :labels => @sa.merchant_names_sorted_by_revenue[0..19],
                          :format => 'image_tag')
    write_graph_to_file(graph, "./graphs/top_5_merchants_by_revenue.html")
  end

  def golden_items_pie_chart
    graph = Gchart.pie_3d(:title  => 'Golden Items',
                          :size   => '600x300',
                          :data   => @sa.golden_items_price_array,
                          :labels => @sa.golden_items_name_array,
                          :format => 'image_tag')
    write_graph_to_file(graph, "./graphs/golden_items.html")
  end

  def top_merchant_items_graph
    graph = Gchart.pie(:title  => 'Top Merchant Items',
                       :size   => '600x300',
                       :data   => @sa.item_prices_for_top_merchant,
                       :labels => @sa.item_names_for_top_merchant,
                       :format => 'image_tag')
    write_graph_to_file(graph, "./graphs/top_merchant_items.html")
  end

  def write_graph_to_file(graph, filepath)
    File.write(filepath, graph)
  end
end

if __FILE__ == $0

se = SalesEngine.from_csv({
  :items         => "./data/items.csv",
  :merchants     => "./data/merchants.csv",
  :customer      => "./data/merchants.csv",
  :invoices      => "./data/invoices.csv",
  :invoice_items => "./data/invoice_items.csv",
  :transactions  => "./data/transactions.csv",
  :customers     => "./data/customers.csv" })

sa = SalesAnalyst.new(se)

charts = Charts.new(sa)

end
