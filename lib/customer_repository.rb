class CustomerRepository

  def initialize(customers)
    @customers = customers
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find { |customer| customer.id == id }
  end

  def find_all_by_first_name(first_name)
    @customers.select { |customer| customer.first_name.downcase.include?(first_name.downcase) }
  end

  def find_all_by_last_name(last_name)
    @customers.select { |customer| customer.last_name.downcase.include?(last_name.downcase) }
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end
end
