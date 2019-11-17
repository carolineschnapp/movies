require_relative 'movie'
require_relative 'rental'

class Customer
  attr_reader :name, :rentals

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def total_amount
    rentals.sum(&:price)
  end

  def frequent_renter_points
    rentals.sum(&:frequent_renter_points)
  end

  def line_items
    statement_body = rentals.map(&:to_s)
  end

  def statement
    <<~STATEMENT
      Rental Record for #{name}
      #{line_items.join("\n")}
      Amount owed is #{total_amount}
      You earned #{frequent_renter_points} frequent renter points
    STATEMENT
  end
end
