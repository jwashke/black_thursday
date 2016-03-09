require_relative 'customer'

class CustomerRepository

  def initialize(customers)
    @customers = populate_customers_array(customers)
  end

  def populate_customers_array(customers)
    customers.map { |customer| Customer.new(customer) }
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find { |customer| customer.id == id }
  end

  def find_all_by_first_name(first_name)
    @customers.select do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    @customers.select do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
