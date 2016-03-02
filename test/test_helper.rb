require 'simplecov'
SimpleCov.start
require_relative '../lib/merchant'
require_relative '../lib/item'

class TestHelper
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
		 time = Time.now
		 [Item.new({
       :id          => "263395237",
       :name        => "Country Ham",
       :description => "Delicious gift for grandpa",
       :unit_price  => BigDecimal.new(10.99,4),
       :merchant_id => "11111111",
       :created_at  => time,
       :updated_at  => time }),
		  Item.new({
	     :id          => "263395237",
	     :name        => "Pencil",
	     :description => "You can use it to write things",
	     :unit_price  => BigDecimal.new(1.99,3),
	     :merchant_id => "55555555",
	     :created_at  => time,
	     :updated_at  => time }),
			Item.new({
		   :id          => "263395237",
		   :name        => "Sugar Cured Ham",
		   :description => "Delicious sugary gift for grandma",
		   :unit_price  => BigDecimal.new(15.99,4),
		   :merchant_id => "33333333",
		   :created_at  => time,
		   :updated_at  => time })]
		 end



 end
