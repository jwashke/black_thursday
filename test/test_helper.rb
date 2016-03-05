require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require_relative '../lib/merchant'
require_relative '../lib/item'
require_relative '../lib/invoice_item'

class TestHelper
	def initialize
		@time = Time.now
	end

	def array_of_merchants
		[Merchant.new({
      :id   => "11111111",
      :name => "Virginia Hams" }),

     Merchant.new({
      :id   => "55555555",
      :name => "Turing School" }),

     Merchant.new({
      :id   => "33333333",
      :name => "Hams and things" })]
   end

	def array_of_items
		[Item.new({
      :id          => "263395237",
      :name        => "Country Ham",
      :description => "Delicious gift for grandpa",
      :unit_price  => "1099",
      :merchant_id => "11111111",
      :created_at  => @time,
      :updated_at  => @time }),

	  Item.new({
      :id          => "263395237",
      :name        => "Pencil",
	    :description => "You can use it to write things",
	    :unit_price  => "199",
	    :merchant_id => "55555555",
	    :created_at  => @time,
	    :updated_at  => @time }),

		Item.new({
		  :id          => "263395237",
		  :name        => "Sugar Cured Ham",
		  :description => "Delicious sugary gift for grandma",
		  :unit_price  => "1599",
		  :merchant_id => "33333333",
		  :created_at  => @time,
		  :updated_at  => @time })]
	end

	def array_of_invoices
		[Invoice.new({
			:id          => "1",
      :customer_id => "2",
      :merchant_id => "12345678",
      :status      => "shipped",
      :created_at  => @time,
      :updated_at  => @time}),

		Invoice.new({
			:id          => "2",
	    :customer_id => "3",
	    :merchant_id => "12345679",
	    :status      => "pending",
	    :created_at  => @time,
	    :updated_at  => @time}),

		Invoice.new({
			:id          => "3",
	    :customer_id => "4",
	    :merchant_id => "12345678",
	    :status      => "returned",
	    :created_at  => @time,
	    :updated_at  => @time})]
	end

  def array_of_invoice_items
		[InvoiceItem.new({
			:id          => "1",
			:item_id     => "2",
			:invoice_id  => "12345678",
			:quantity    => "1",
			:unit_price  => "1599",
			:created_at  => @time,
			:updated_at  => @time}),

		InvoiceItem.new({
			:id          => "2",
			:item_id     => "2",
			:invoice_id  => "4",
			:quantity    => "1",
			:unit_price  => "2099",
			:created_at  => @time,
			:updated_at  => @time}),

		InvoiceItem.new({
			:id          => "3",
			:item_id     => "3",
			:invoice_id  => "4",
			:quantity    => "1",
			:unit_price  => "599",
			:created_at  => @time,
			:updated_at  => @time})]
	end

	def sample_item_hash_info
		[{
      :id          => "263395237",
      :name        => "Country Ham",
      :description => "Delicious gift for grandpa",
      :unit_price  => BigDecimal.new(10.99,4),
      :merchant_id => "11111111",
      :created_at  => @time,
      :updated_at  => @time }]
	end

	def sample_item_object
	  [Item.new({
      :id          => "263395237",
      :name        => "Country Ham",
      :description => "Delicious gift for grandpa",
      :unit_price  => BigDecimal.new(10.99,4),
      :merchant_id => "11111111",
      :created_at  => @time,
      :updated_at  => @time })]
  end

  def sample_merchant_hash_info
	  [{
	    :id   => "11111111",
	    :name => "Virginia Hams" }]
	end

  def sample_merchant_object
	  [Merchant.new({
	    :id   => "11111111",
	    :name => "Virginia Hams" })]
	end
end
