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

  def statement
    <<~STATEMENT
      Rental Record for #{@name}
      #{line_items}
      Amount owed is #{total_amount}
      You earned #{frequent_renter_points} frequent renter points
    STATEMENT
  end

  def line_items
    rentals.map { |rental| "  #{rental}" }.join("\n")
  end

  def total_amount
    rentals.inject(0) { |total, rental| total + rental.charge }
  end

  def frequent_renter_points
    rentals.inject(0) { |total, rental| total + rental.frequent_renter_points }
  end
end
