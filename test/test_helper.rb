require_relative '../lib/merchant'
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
 end
