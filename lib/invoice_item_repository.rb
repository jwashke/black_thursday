require_relative 'invoice_item'

class InvoiceItemRepository
  def initialize(invoice_items)
    @invoice_items = populate_invoice_item_array(invoice_items)
  end

  def populate_invoice_item_array(invoice_items)
    invoice_items.map { |invoice_item| InvoiceItem.new(invoice_item) }
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(id)
    @invoice_items.select { |invoice_item| invoice_item.item_id == id }
  end

  def find_all_by_invoice_id(id)
    @invoice_items.select { |invoice_item| invoice_item.invoice_id == id }
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
