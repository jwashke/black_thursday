class InvoiceRepository

  def initialize(invoices)
    @invoices = invoices
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    @invoices.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.select { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    @invoices.select { |invoice| invoice.status == status }
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
