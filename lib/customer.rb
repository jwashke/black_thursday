class Customer
  def initialize(info)
    @info = info
  end

  def id
    @info[:id]
  end

  def first_name
    @info[:first_name]
  end

  def last_name
    @info[:last_name]
  end

  def created_at
    Time.parse(@info[:created_at])
  end

  def updated_at
    Time.parse(@info[:updated_at])
  end
end
