require 'googlecharts'

class Charts

  def initialize(sa)
    @sa = sa
    top_5_merchants_pie_chart
  end

  def top_5_merchants_pie_chart
    graph = Gchart.pie_3d(:theme => :thirty7signals,
                          :title => 'Top Merchants',
                  :size => '600x300',
                  :data => @sa.merchants_revenue_hash[0..4],
                  :labels => @sa.merchant_names_sorted_by_revenue[0..4])
    File.write('./graphs/top_5_merchants_by_revenue', graph)
  end
end
