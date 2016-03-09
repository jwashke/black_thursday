module InvoiceAnalysis

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
end
