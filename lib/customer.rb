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
    <<~STATEMENT
      Rental Record for #{@name}
      #{line_items}
      Amount owed is #{total_amount}
      You earned #{frequent_renter_points} frequent renter points
    STATEMENT
  end

  def line_items
    line_items = ''
    @rentals.each do |rental|
      line_items += "  #{rental}\n"
    end
    line_items.chomp
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
