require_relative 'movie'
require_relative 'rental'

class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    result = "Rental Record for #{@name}\n"
    @rentals.each do |rental|
      result += "  #{rental}\n"
    end
    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result += "\n"
  end

  def total_amount
    total_amount = 0
    @rentals.each do |rental|
      total_amount += rental.charge
    end
    total_amount
  end

  def frequent_renter_points
    frequent_renter_points = 0
    @rentals.each do |rental|
      frequent_renter_points += rental.frequent_renter_points
    end
    frequent_renter_points
  end
end
